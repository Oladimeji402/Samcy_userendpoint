<?php
header("Content-Type: application/json");

require 'vendor/autoload.php';

require_once 'config/database.php';
require_once 'includes/functions.php';

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

$data = json_decode(file_get_contents("php://input"), true);

// Validate required inputs
if (empty($data['email']) || empty($data['password']) || empty($data['role'])) {
  http_response_code(400);
  echo json_encode(['error' => 'Email, password, and role are required']);
  exit;
}

$email = sanitize($data['email']);
$password = $data['password'];
$role = strtolower(sanitize($data['role']));
$rememberMe = isset($data['rememberMe']) && $data['rememberMe'] ? true : false;

// Allow only these 4 roles
$allowedRoles = ['admin', 'instructor', 'student', 'parent'];
if (!in_array($role, $allowedRoles)) {
  http_response_code(400);
  echo json_encode(['error' => 'Invalid role']);
  exit;
}

// Fetch user by email
$stmt = $pdo->prepare("SELECT * FROM users WHERE email = ?");
$stmt->execute([$email]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);

// Check email, password and role
if (!$user || !password_verify($password, $user['password']) || strtolower($user['role']) !== $role) {
  http_response_code(401);
  echo json_encode(['error' => 'Invalid credentials or role']);
  exit;
}

// expiry time for JWT
$expiry = $rememberMe ? (60 * 60 * 24 * 7) : (60 * 60); //  1 hour or 7 days

$payload = [
  "id" => $user['id'],
  "email" => $user['email'],
  "role" => $user['role'],
  "department" => $user['department'],
  "iat" => time(),
  "exp" => time() + $expiry
];


$jwt = JWT::encode($payload, $_ENV['JWT_SECRET'], 'HS256');
if ($user['first_login']) {
  $subject = '✅ First Login Detected';

  $htmlBody = "
  <html>
    <body style='margin:0; padding:0; font-family:Arial, sans-serif; background-color:#121212; color:#ffffff;'>
      <table width='100%' cellpadding='0' cellspacing='0'>
        <tr>
          <td align='center'>
            <table width='600' cellpadding='30' cellspacing='0' style='background-color:#1e1e1e; border-radius:8px;'>
              <tr>
                <td>
                  <h2 style='color:#ff4c4c;'>Dear {$user['firstName']},</h2>
                  <p style='color:#dcdcdc;'>Thank you for logging in to your account at <strong>Samcy</strong> for the first time.</p>
                  <p style='color:#dcdcdc;'>To keep your account secure, we've logged this login event:</p>
                  <p style='margin-top:15px; font-size:15px;'>
                    <strong>Login Time:</strong> " . date('Y-m-d H:i:s') . "<br>
                    <strong>IP Address:</strong> " . $_SERVER['REMOTE_ADDR'] . "
                  </p>
                  <p style='color:#999999;'>If this wasn't you, please change your password immediately.</p>
                  <hr style='border: 0; border-top: 1px solid #333; margin: 30px 0;'>
                  <p style='color:#aaaaaa;'>Thanks,<br><strong>Samcy Security Team</strong></p>
                </td>
              </tr>
            </table>
            <p style='margin-top:20px; font-size:12px; color:#666;'>Use of our service is subject to our <a href='#' style='color:#4da6ff;'>Terms</a> and <a href='#' style='color:#4da6ff;'>Privacy Policy</a>.</p>
          </td>
        </tr>
      </table>
    </body>
  </html>";

  $altBody = "Hi {$user['firstName']},\n\nFirst login detected on " . date('Y-m-d H:i:s') . " from IP " . $_SERVER['REMOTE_ADDR'];

  sendMail($user['email'], $user['firstName'], $subject, $htmlBody, $altBody);

  // mark login
  $update = $pdo->prepare("UPDATE users SET first_login = 0 WHERE id = ?");
  $update->execute([$user['id']]);
}


echo json_encode([
  "message" => "Login successful",
  "token" => $jwt,
  "user" => [
    "id" => $user['id'],
    "firstName" => $user['firstName'],
    "lastName" => $user['lastName'],
    "email" => $user['email'],
    "role" => $user['role'],
    "department" => $user['department'],
  ]
]);
