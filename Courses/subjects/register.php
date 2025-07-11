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

// Authenticate token
tokenHeader();
$authHeader = getallheaders()['Authorization'];
$token = str_replace('Bearer ', '', $authHeader);

try {
    $decoded = JWT::decode($token, new Key($_ENV['JWT_SECRET'], 'HS256'));
    if (strtolower($decoded->role) !== 'student') {
        http_response_code(403);
        echo json_encode(['error' => 'Access denied. Only students can register subjects.']);
        exit;
    }

    $userId = $decoded->id;
    $userDept = strtolower($decoded->department ?? '');

    $departmentMap = [
        'science' => 'dept/2025/001',
        'art' => 'dept/2025/002',
        'commercial' => 'dept/2025/003',
    ];

    $departmentId = $departmentMap[$userDept] ?? null;
    if (!$departmentId) {
        http_response_code(400);
        echo json_encode(['error' => 'Invalid department']);
        exit;
    }

    $data = json_decode(file_get_contents("php://input"), true);
    $programId = $data['program_id'] ?? null;
    $subjectIds = $data['subject_ids'] ?? [];

    if (!$programId || !is_array($subjectIds) || count($subjectIds) === 0) {
        http_response_code(400);
        echo json_encode(['error' => 'Program ID and subject_ids are required']);
        exit;
    }

    // Validate compulsory subjects are included
    $stmt = $pdo->prepare("
        SELECT id FROM course_subjects
        WHERE program_id = ? AND department_id = ? AND is_compulsory = 1
    ");
    $stmt->execute([$programId, $departmentId]);
    $compulsorySubjects = $stmt->fetchAll(PDO::FETCH_COLUMN);

    $missing = array_diff($compulsorySubjects, $subjectIds);
    if (count($missing) > 0) {
        http_response_code(422);
        echo json_encode(['error' => 'All compulsory subjects must be selected', 'missing_compulsory_ids' => array_values($missing)]);
        exit;
    }

    // Save selections
    $insertStmt = $pdo->prepare("
        INSERT IGNORE INTO student_subjects (user_id, program_id, course_subject_id)
        VALUES (?, ?, ?)
    ");

    foreach ($subjectIds as $subId) {
        $insertStmt->execute([$userId, $programId, $subId]);
    }

    echo json_encode([
        'status' => 'success',
        'message' => 'Subjects registered successfully',
        'total_selected' => count($subjectIds)
    ]);
} catch (Exception $e) {
    http_response_code(401);
    echo json_encode(['error' => 'Invalid or expired token']);
    exit;
}
