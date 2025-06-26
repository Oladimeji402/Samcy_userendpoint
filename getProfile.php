<?php
header("Content-Type: application/json");

require_once 'config/database.php';
require_once 'includes/functions.php';
require 'vendor/autoload.php';

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

// Get Authorization header
tokenHeader(); // checks header exists or exits
$authHeader = getallheaders()['Authorization'];

// Extract the token
$token = str_replace('Bearer ', '', $authHeader);

try {
    $decoded = JWT::decode($token, new Key($_ENV['JWT_SECRET'], 'HS256'));
    $userId = $decoded->id;

    // Fetch full profile
    $stmt = $pdo->prepare("SELECT id, firstName, lastName, email, phone, maritalStatus, dob, state, localGovt, address, nationality, nin, department, gender, role FROM users WHERE id = ?");
    $stmt->execute([$userId]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$user) {
        http_response_code(404);
        echo json_encode(['error' => 'User not found']);
        exit;
    }

    echo json_encode(['user' => $user]);
} catch (Exception $e) {
    http_response_code(401);
    echo json_encode(['error' => 'Invalid or expired token']);
    exit;
}
