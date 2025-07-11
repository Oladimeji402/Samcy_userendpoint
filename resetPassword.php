<?php
header("Content-Type: application/json");

require_once 'config/database.php';
require_once 'includes/functions.php';

$data = json_decode(file_get_contents("php://input"), true);

$token = $data['token'] ?? '';
$newPassword = $data['newPassword'] ?? '';
$confirmPassword = $data['confirmPassword'] ?? '';

if (!$token || !$newPassword || !$confirmPassword) {
    http_response_code(400);
    echo json_encode(['error' => 'All fields are required.']);
    exit;
}

if (!isStrongPassword($newPassword)) {
    http_response_code(400);
    echo json_encode(['error' => 'Password must be at least 8 characters.']);
    exit;
}

if ($newPassword !== $confirmPassword) {
    http_response_code(400);
    echo json_encode(['error' => 'Passwords do not match.']);
    exit;
}

$tokenHash = hash('sha256', $token);

// Find the token in the password_resets table
$stmt = $pdo->prepare("SELECT user_id FROM password_resets WHERE token_hash = ? AND expires_at > NOW()");
$stmt->execute([$tokenHash]);
$record = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$record) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid or expired token.']);
    exit;
}

$userId = $record['user_id'];
$hashedPassword = password_hash($newPassword, PASSWORD_BCRYPT);

// Update the user’s password
$stmt = $pdo->prepare("UPDATE users SET password = ? WHERE id = ?");
$stmt->execute([$hashedPassword, $userId]);

// Delete used token
$pdo->prepare("DELETE FROM password_resets WHERE user_id = ?")->execute([$userId]);

echo json_encode(['message' => 'Password successfully reset.']);
