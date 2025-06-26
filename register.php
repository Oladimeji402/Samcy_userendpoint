<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Access-Control-Allow-Methods: POST, OPTIONS");

header("Content-Type: application/json");
require_once 'config/database.php';
require_once 'includes/functions.php';




use Firebase\JWT\JWT;
use Firebase\JWT\Key;

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;




$data = json_decode(file_get_contents("php://input"), true);
$requiredFields = ['firstName', 'lastName', 'email', 'phone', 'password', 'confirmPassword', 'maritalStatus', 'dob', 'state', 'localGovt', 'address', 'nationality', 'nin', 'department', 'gender', 'role', 'privacyPolicy'];

foreach ($requiredFields as $field) {
  if (empty($data[$field])) {
    http_response_code(400);
    echo json_encode(['error' => "$field is required"]);
    exit;
  }
}

$firstName = sanitize($data['firstName']);
$lastName = sanitize($data['lastName']);
$email = sanitize($data['email']);
$phone = sanitize($data['phone']);
$password = $data['password'];
$confirmPassword = $data['confirmPassword'];
$maritalStatus = sanitize($data['maritalStatus']);
$dob = sanitize($data['dob']);
$state = sanitize($data['state']);
$localGovt = sanitize($data['localGovt']);
$address = sanitize($data['address']);
$nationality = sanitize($data['nationality']);
$nin = sanitize($data['nin']);
$department = sanitize($data['department']);
$gender = sanitize($data['gender']);
$role = sanitize($data['role']);
$privacyPolicy = filter_var($data['privacyPolicy'], FILTER_VALIDATE_BOOLEAN);

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
  http_response_code(204);
  exit;
}


if (!isValidEmail($email)) {
  http_response_code(400);
  echo json_encode(['error' => 'Invalid email format']);
  exit;
}

if (!isStrongPassword($password)) {
  http_response_code(400);
  echo json_encode(['error' => 'Password must be at least 8 characters long']);
  exit;
}

if ($password !== $confirmPassword) {
  http_response_code(400);
  echo json_encode(['error' => 'Passwords do not match']);
  exit;
}

$hashedPassword = password_hash($password, PASSWORD_BCRYPT);

// Validate role
$allowedRoles = ['admin', 'instructor', 'student', 'parent'];
$role = strtolower(sanitize($data['role']));
if (!in_array($role, $allowedRoles)) {
  http_response_code(400);
  echo json_encode(['error' => 'Invalid role selected']);
  exit;
}


// Check if user exists
$stmt = $pdo->prepare("SELECT id FROM users WHERE email = ?");
$stmt->execute([$email]);
if ($stmt->fetch()) {
  http_response_code(409);
  echo json_encode(['error' => 'Email already exists']);
  exit;
}

// Check if full name already exists
$stmt = $pdo->prepare("SELECT id FROM users WHERE firstName = ? AND lastName = ?");
$stmt->execute([$firstName, $lastName]);
if ($stmt->fetch()) {
  http_response_code(409);
  echo json_encode(['error' => 'A user with this name already exists']);
  exit;
}


// Check if phone number already exists
$stmt = $pdo->prepare("SELECT id FROM users WHERE phone = ?");
$stmt->execute([$phone]);
if ($stmt->fetch()) {
  http_response_code(409);
  echo json_encode(['error' => 'Phone number already exists']);
  exit;
}

// Check if NIN already exists
$stmt = $pdo->prepare("SELECT id FROM users WHERE nin = ?");
$stmt->execute([$nin]);
if ($stmt->fetch()) {
  http_response_code(409);
  echo json_encode(['error' => 'NIN already exists']);
  exit;
}

$userId = generateCustomUserId($pdo);



// Insert new user
$stmt = $pdo->prepare("INSERT INTO users (id, firstName, lastName, email, phone, password, maritalStatus, dob, state, localGovt, address, nationality, nin, department, gender, role, privacyPolicy) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
$stmt->execute([$userId, $firstName, $lastName, $email, $phone, $hashedPassword, $maritalStatus, $dob, $state, $localGovt, $address, $nationality, $nin, $department, $gender, $role, $privacyPolicy]);


$mail = new PHPMailer(true);
try {
  $mail->isSMTP();
  $mail->Host = $_ENV['MAIL_HOST'];
  $mail->SMTPAuth = true;
  $mail->Username = $_ENV['MAIL_USER'];
  $mail->Password = $_ENV['MAIL_PASS'];
  $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
  $mail->Port = $_ENV['MAIL_PORT'];

  $mail->setFrom($_ENV['MAIL_FROM'], 'Samcy Support');
  $mail->addAddress($email, $firstName);
  $mail->addReplyTo($_ENV['MAIL_FROM'], 'Samcy Support');

  $mail->isHTML(true);
  $mail->Subject = '🎉 Welcome to Samcy!';
  $mail->Body = "
<html>
  <body style='margin:0; padding:0; font-family:Arial, sans-serif; background-color:#121212; color:#ffffff;'>
    <table width='100%' cellpadding='0' cellspacing='0'>
      <tr>
        <td align='center'>
          <table width='600' cellpadding='30' cellspacing='0' style='background-color:#1e1e1e; border-radius:8px;'>
            <tr>
              <td>
                <h2 style='color:#ff4c4c; margin-bottom: 20px;'>🎉 Welcome, {$firstName}!</h2>
                <p style='color:#dcdcdc;'>Thank you for registering at <strong>Samcy</strong>. We're excited to have you with us.</p>
                <p style='color:#dcdcdc;'>You can now log in to your dashboard, manage your profile, and explore all features available for your role: <strong style='color:#4da6ff;'>{$role}</strong>.</p>
                <p style='margin-top: 30px; font-style: italic; color:#999;'>If you have any questions or need help, don’t hesitate to contact our support team.</p>
                <hr style='border: 0; border-top: 1px solid #333; margin: 30px 0;'>
                <p style='color:#aaaaaa;'>Best regards,<br><strong>Samcy Support Team</strong></p>
              </td>
            </tr>
          </table>
          <p style='margin-top:20px; font-size:12px; color:#666;'>By continuing, you agree to our <a href='#' style='color:#4da6ff;'>Terms of Use</a> and <a href='#' style='color:#4da6ff;'>Privacy Policy</a>.</p>
        </td>
      </tr>
    </table>
  </body>
</html>";

  $mail->AltBody = "Welcome, {$firstName}! Thank you for joining Samcy.";

  $mail->send();
} catch (Exception $e) {
  // Don’t block the registration process if email fails
  error_log("Failed to send welcome email to $email: " . $mail->ErrorInfo);
}

// JWT generation
$payload = [
  "id" => $userId,
  "email" => $email,
  "role" => $role,
  "iat" => time(),
  "exp" => time() + (60 * 60 * 24 * 7) // 7 days
];

$jwt = JWT::encode($payload, $_ENV['JWT_SECRET'], 'HS256');

echo json_encode([
  "message" => "User registered successfully",
  "token" => $jwt,
  "user" => [
    "id" => $userId,
    "firstName" => $firstName,
    "lastName" => $lastName,
    "email" => $email,
    "role" => $role
  ]
]);
