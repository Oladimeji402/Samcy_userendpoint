<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

header("Content-Type: application/json");

require_once '../../config/database.php';
require_once '../../includes/functions.php';
require '../../vendor/autoload.php';

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

// Step 1: Check and decode token
tokenHeader();
$authHeader = getallheaders()['Authorization'];
$token = str_replace('Bearer ', '', $authHeader);

try {
    $decoded = JWT::decode($token, new Key($_ENV['JWT_SECRET'], 'HS256'));

    // Step 2: Get department from token and map to actual department_id
    $userDept = strtolower($decoded->department ?? '');

    // Map department names to their actual DB IDs
    $departmentMap = [
        'science' => 'dept/2025/001',
        'art' => 'dept/2025/002',
        'commercial' => 'dept/2025/003',
    ];

    $departmentId = $departmentMap[$userDept] ?? null;

    if (!$departmentId) {
        http_response_code(400);
        echo json_encode(['error' => 'Invalid or missing department in token']);
        exit;
    }

    // Step 3: Get program_id from query
    $programId = $_GET['program_id'] ?? null;

    if (!$programId) {
        http_response_code(400);
        echo json_encode(['error' => 'Program ID is required']);
        exit;
    }
    // Step 3.1: Get program name
    $programStmt = $pdo->prepare('SELECT name FROM programs WHERE id = ?');
    $programStmt->execute([$programId]);
    $programRow = $programStmt->fetch(PDO::FETCH_ASSOC);

    if (!$programRow) {
        http_response_code(404);
        echo json_encode(['error' => 'Program not found']);
        exit;
    }

    $programName = $programRow['name'];


    // Step 4: Fetch subjects based on program + department
    $stmt = $pdo->prepare("
        SELECT cs.id AS course_subject_id, gs.name, cs.is_compulsory
        FROM course_subjects cs
        JOIN global_subjects gs ON cs.global_subject_id = gs.global_subject_id
        WHERE cs.program_id = ? AND cs.department_id = ?
    ");
    $stmt->execute([$programId, $departmentId]);
    $subjects = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode([
        'status' => 'success',
        'program_id' => $programId,
        'program_name' => $programName,
        'department' => $userDept,
        'subject_count' => count($subjects),
        'subjects' => $subjects
    ]);
} catch (Exception $e) {
    http_response_code(401);
    echo json_encode(['error' => 'Invalid or expired token']);
    exit;
}
