<?php
header("Content-Type: application/json");

require_once 'config/database.php';
require_once 'includes/functions.php';
require 'vendor/autoload.php';

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

$data = json_decode(file_get_contents("php://input"), true);
$email = sanitize($data['email'] ?? '');

if (!isValidEmail($email)) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid email address']);
    exit;
}

// Check if user exists
$stmt = $pdo->prepare("SELECT id, firstName FROM users WHERE email = ?");
$stmt->execute([$email]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$user) {
    http_response_code(404);
    echo json_encode(['error' => 'No user found with this email']);
    exit;
}

// Generate secure token
$token = bin2hex(random_bytes(32));
$expires = date('Y-m-d H:i:s', time() + 60 * 5); // 5 minutes

// Store token in DB
$stmt = $pdo->prepare("UPDATE users SET reset_token = ?, reset_token_expires = ? WHERE id = ?");
$stmt->execute([$token, $expires, $user['id']]);

// Send email
$mail = new PHPMailer(true);
try {
    $resetLink = $_ENV['RESET_PASSWORD_URL'] . "?token=$token";

    $mail->isSMTP();
    $mail->Host = $_ENV['MAIL_HOST'];
    $mail->SMTPAuth = true;
    $mail->Username = $_ENV['MAIL_USER'];
    $mail->Password = $_ENV['MAIL_PASS'];
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
    $mail->Port = $_ENV['MAIL_PORT'];

    $mail->setFrom($_ENV['MAIL_FROM'], 'Samcy Support');
    $mail->addReplyTo($_ENV['MAIL_FROM'], 'Samcy Support');
    $mail->addAddress($email, $user['firstName']);

    $mail->isHTML(true);
    $mail->Subject = 'Password Reset Request';
    $mail->Body = "
<html>
  <body style='margin:0; padding:0; font-family:Arial, sans-serif; background-color:#121212; color:#ffffff;'>
    <table width='100%' cellpadding='0' cellspacing='0'>
      <tr>
        <td align='center'>
          <table width='600' cellpadding='30' cellspacing='0' style='background-color:#1e1e1e; border-radius:8px;'>
            <tr>
              <td>
                <h2 style='color:#ff4c4c;'>Password Reset Request</h2>
                <p style='color:#dcdcdc;'>Hi {$user['firstName']},</p>
                <p style='color:#dcdcdc;'>We received a request to reset your password. Click the button below to proceed:</p>
                <p style='text-align: center; margin: 30px 0;'>
                  <a href='{$resetLink}' style='padding: 12px 24px; background-color: #4CAF50; color: #ffffff; text-decoration: none; border-radius: 5px; font-weight: bold;'>Reset Password</a>
                </p>
                <p style='color:#bbbbbb;'>If the button doesn’t work, copy and paste this URL into your browser:</p>
                <p style='word-break: break-all; color:#4da6ff;'><a href='{$resetLink}' style='color:#4da6ff;'>{$resetLink}</a></p>
                <p style='color:#999999;'>Note: This link will expire in <strong>5 minutes</strong>.</p>
                <hr style='border: 0; border-top: 1px solid #333; margin: 30px 0;'>
                <p style='color:#aaaaaa;'>Regards,<br><strong>Samcy Support Team</strong></p>
              </td>
            </tr>
          </table>
          <p style='margin-top:20px; font-size:12px; color:#666;'>If you didn’t request this, please ignore this email or contact support.</p>
        </td>
      </tr>
    </table>
  </body>
</html>
";

    $mail->AltBody = "Hi {$user['firstName']},\n\nYou requested a password reset. Click the link below to reset your password:\n\n{$resetLink}\n\nThis link expires in 5 minutes.\n\nIf you didn't request this, please ignore the email.";



    $mail->send();
    echo json_encode(['message' => 'Password reset link sent']);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Email could not be sent.', 'details' => $mail->ErrorInfo]);
}
