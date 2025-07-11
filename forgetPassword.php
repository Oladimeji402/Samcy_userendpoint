<?php
header("Content-Type: application/json");

require_once 'config/database.php';
require_once 'includes/functions.php';
require 'vendor/autoload.php';

use PHPMailer\PHPMailer\Exception;

$data = json_decode(file_get_contents("php://input"), true);
$email = sanitize($data['email'] ?? '');
$ip = $_SERVER['REMOTE_ADDR'];

// === RATE LIMITING: Max 3 requests per email/IP in 15 mins === //
$stmt = $pdo->prepare("
  SELECT COUNT(*) 
  FROM password_reset_requests 
  WHERE (email = ? OR ip_address = ?) 
  AND requested_at > NOW() - INTERVAL 15 MINUTE
");
$stmt->execute([$email, $ip]);
$requestCount = $stmt->fetchColumn();

if ($requestCount >= 3) {
  http_response_code(429);
  echo json_encode(['error' => 'Too many reset requests. Please wait 15 minutes.']);
  exit;
}

// Log this request
$stmt = $pdo->prepare("INSERT INTO password_reset_requests (email, ip_address) VALUES (?, ?)");
$stmt->execute([$email, $ip]);

// === Proceed to password reset flow === //
if (!isValidEmail($email)) {
  http_response_code(400);
  echo json_encode(['error' => 'Invalid email address.']);
  exit;
}

// ✅ NEW: Check if user exists and return specific error if not
$stmt = $pdo->prepare("SELECT id, firstName FROM users WHERE email = ?");
$stmt->execute([$email]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$user) {
  http_response_code(404);
  echo json_encode(['error' => 'No account found with this email address.']);
  exit;
}

// === User exists, continue with reset ===
$userId = $user['id'];
$name = $user['firstName'];

$token = bin2hex(random_bytes(32));
$tokenHash = hash('sha256', $token);
$expires = date('Y-m-d H:i:s', time() + 60 * 30); // 30 minutes

// Remove previous tokens
$pdo->prepare("DELETE FROM password_resets WHERE user_id = ?")->execute([$userId]);

// Save new token
$stmt = $pdo->prepare("INSERT INTO password_resets (user_id, token_hash, expires_at) VALUES (?, ?, ?)");
$stmt->execute([$userId, $tokenHash, $expires]);

// Prepare and send email
$resetLink = $_ENV['RESET_PASSWORD_URL'] . "?token=$token";
$subject = 'Password Reset Request';

$htmlBody = "
<html>
  <body style='font-family: Georgia, serif; background-color: #f8f9fa; color: #212529; margin: 0; padding: 0;'>
    <div style='max-width: 480px; margin: 40px auto; background: #fff; border: 1px solid #e3e3e3; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.04); padding: 32px;'>
      <h2 style='font-family: Georgia, serif; color: #2c3e50; margin-top: 0;'>Password Reset Request</h2>
      <p style='font-size: 16px;'>Dear $name,</p>
      <p style='font-size: 15px;'>
        We received a request to reset your password. Click the button below to set a new password. This link is valid for 30 minutes.
      </p>
      <p style='text-align: center; margin: 32px 0;'>
        <a href='$resetLink' style='display: inline-block; background: #2c3e50; color: #fff; text-decoration: none; font-size: 16px; padding: 12px 28px; border-radius: 4px; border: 1px solid #2c3e50;'>Reset Password</a>
      </p>
      <p style='font-size: 14px; color: #555;'>
        If the button above does not work, copy and paste this link into your browser:<br>
        <span style='word-break: break-all; color: #2c3e50;'>$resetLink</span>
      </p>
      <hr style='border: none; border-top: 1px solid #e3e3e3; margin: 32px 0 16px 0;'>
      <p style='font-size: 13px; color: #888;'>
        If you did not request a password reset, please ignore this email.
      </p>
    </div>
  </body>
</html>";

$altBody = "Dear $name,\n\nWe received a request to reset your password.\nReset your password using this link:\n$resetLink\n\nThis link expires in 30 minutes.\n\nIf you did not request this, please ignore this email.";

try {
  sendMail($email, $name, $subject, $htmlBody, $altBody);
} catch (Exception $e) {
  error_log('Password reset email failed for user ID ' . $userId . ' (' . $email . '): ' . $e->getMessage());
}

echo json_encode(['message' => 'Password reset link sent successfully.']);
