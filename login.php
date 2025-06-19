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
$role = strtolower(sanitize($data['role'])); // normalize to lowercase
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

// Set expiry time for JWT
$expiry = $rememberMe ? (60 * 60 * 24 * 7) : (60 * 60); // 1 hour or 7 days

$payload = [
    "id" => $user['id'],
    "email" => $user['email'],
    "role" => $user['role'],
    "iat" => time(),
    "exp" => time() + $expiry
];

$jwt = JWT::encode($payload, $_ENV['JWT_SECRET'], 'HS256');

if ($user['first_login']) {
    // Send first login email

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
        $mail->addAddress($user['email'], $user['firstName']);
        $mail->addReplyTo($_ENV['MAIL_FROM'], 'Samcy Support');

        $mail->isHTML(true);
        $mail->Subject = '✅ First Login Detected';
        $mail->Body = "
            <html>
            <body>
                <p>Hi {$user['firstName']},</p>
                <p>We've noticed your first login to Samcy. Welcome aboard!</p>
                <p>If this wasn't you, please reset your password immediately.</p>
                <p>Time: " . date('Y-m-d H:i:s') . "<br>IP Address: " . $_SERVER['REMOTE_ADDR'] . "</p>
                <p>Stay safe,<br>Samcy Security Team</p>
            </body>
            </html>
        ";
        $mail->AltBody = "Hi {$user['firstName']},\n\nFirst login detected on " . date('Y-m-d H:i:s') . " from IP " . $_SERVER['REMOTE_ADDR'];

        $mail->send();
    } catch (Exception $e) {
        error_log("First login email failed: " . $mail->ErrorInfo);
    }

    // Update user to mark first login done
    $update = $pdo->prepare("UPDATE users SET first_login = 0 WHERE id = ?");
    $update->execute([$user['id']]);
}

// Successful login response
echo json_encode([
    "message" => "Login successful",
    "token" => $jwt,
    "user" => [
        "id" => $user['id'],
        "firstName" => $user['firstName'],
        "lastName" => $user['lastName'],
        "email" => $user['email'],
        "role" => $user['role']
    ]
]);
