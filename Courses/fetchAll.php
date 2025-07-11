<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");


if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}


header("Content-Type: application/json");

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../includes/functions.php';

try {
    // Fetch all offerings
    $stmt = $pdo->query("SELECT * FROM program_offerings");
    $offerings = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode([
        'offerings' => $offerings
    ]);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Something went wrong']);
}
