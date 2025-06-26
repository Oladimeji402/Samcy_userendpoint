<?php
header("Content-Type: application/json");

require_once 'config/database.php';
require_once 'includes/functions.php';
require 'vendor/autoload.php';

use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

$authHeader = getallheaders()['Authorization'] ?? '';
$token = str_replace('Bearer ', '', $authHeader);

try {
    $decoded = JWT::decode($token, new Key($_ENV['JWT_SECRET'], 'HS256'));
    $userId = $decoded->id;

    $data = json_decode(file_get_contents("php://input"), true);

    // Fetch existing user info
    $stmt = $pdo->prepare("SELECT firstName, lastName, email, gender, address FROM users WHERE id = ?");
    $stmt->execute([$userId]);
    $existing = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$existing) {
        http_response_code(404);
        echo json_encode(['error' => 'User not found']);
        exit;
    }

    // Sanitize inputs and use existing values if not provided
    $firstName = sanitize($data['firstName'] ?? $existing['firstName']);
    $lastName = sanitize($data['lastName'] ?? $existing['lastName']);
    $email = sanitize($data['email'] ?? $existing['email']);
    $gender = sanitize($data['gender'] ?? $existing['gender']);
    $address = sanitize($data['address'] ?? $existing['address']);

    if (!isValidEmail($email)) {
        http_response_code(400);
        echo json_encode(['error' => 'Invalid email']);
        exit;
    }

    // Check if email is taken by another user
    $stmt = $pdo->prepare("SELECT id FROM users WHERE email = ? AND id != ?");
    $stmt->execute([$email, $userId]);
    if ($stmt->fetch()) {
        http_response_code(409);
        echo json_encode(['error' => 'Email already taken']);
        exit;
    }

    $stmt = $pdo->prepare("UPDATE users SET firstName = ?, lastName = ?, email = ?, gender = ?, address = ? WHERE id = ?");
    $stmt->execute([$firstName, $lastName, $email, $gender, $address, $userId]);

    // Fetch IP and time
    $ip = $_SERVER['REMOTE_ADDR'] ?? 'Unknown';
    $time = date('Y-m-d H:i:s');

    // Send security alert email
    $mail = new PHPMailer(true);
    try {
        $mail->isSMTP();
        $mail->Host = $_ENV['MAIL_HOST'];
        $mail->SMTPAuth = true;
        $mail->Username = $_ENV['MAIL_USER'];
        $mail->Password = $_ENV['MAIL_PASS'];
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
        $mail->Port = $_ENV['MAIL_PORT'];

        $mail->setFrom($_ENV['MAIL_FROM'], 'Samcy Security');
        $mail->addAddress($email, $firstName);
        $mail->addReplyTo($_ENV['MAIL_FROM'], 'Samcy Support');

        $mail->isHTML(true);
        $mail->Subject = '🔐 Profile Update Notification';
        $mail->Body = "
<html>
  <body style='margin:0; padding:0; font-family:Arial, sans-serif; background-color:#121212; color:#ffffff;'>
    <table width='100%' cellpadding='0' cellspacing='0'>
      <tr>
        <td align='center'>
          <table width='600' cellpadding='30' cellspacing='0' style='background-color:#1e1e1e; border-radius:8px;'>
            <tr>
              <td>
                <h2 style='color:#ff4c4c;'>⚠️ Profile Updated</h2>
                <p style='color:#dcdcdc;'>Hi {$firstName},</p>
                <p style='color:#dcdcdc;'>We noticed that your profile information was recently updated.</p>
                <p style='color:#dcdcdc;'>If you made this change, no further action is required.</p>
                <p style='color:#ff9999;'>If you did <strong>not</strong> make this change, please reset your password immediately to secure your account.</p>
                <p style='margin-top: 20px; font-size: 14px;'>
                  <strong style='color:#cccccc;'>Time:</strong> {$time}<br>
                  <strong style='color:#cccccc;'>IP Address:</strong> {$ip}
                </p>
                <hr style='border: 0; border-top: 1px solid #333; margin: 30px 0;'>
                <p style='color:#aaaaaa;'>Stay safe,<br><strong>Samcy Security Team</strong></p>
              </td>
            </tr>
          </table>
          <p style='margin-top:20px; font-size:12px; color:#666;'>Need help? Contact <a href='#' style='color:#4da6ff;'>Samcy Support</a>.</p>
        </td>
      </tr>
    </table>
  </body>
</html>
";

        $mail->AltBody = "Hi {$firstName},\n\nYour profile was updated on {$time} from IP: {$ip}.\n\nIf this wasn’t you, please reset your password immediately.\n\n- Samcy Security Team";

        $mail->send();
    } catch (Exception $e) {
        error_log("Profile update alert email failed: " . $mail->ErrorInfo);
    }

    echo json_encode(['message' => 'Profile updated successfully']);
} catch (Exception $e) {
    http_response_code(401);
    echo json_encode(['error' => 'Invalid or expired token']);
    exit;
}
