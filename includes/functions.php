<?php
function sanitize($data)
{
    return htmlspecialchars(strip_tags(trim($data)));
}

function isValidEmail($email)
{
    return filter_var($email, FILTER_VALIDATE_EMAIL);
}

function isStrongPassword($password)
{
    return strlen($password) >= 8;
}

function generateCustomUserId($pdo)
{
    $prefix = "samcy2025-";
    $stmt = $pdo->query("SELECT id FROM users WHERE id LIKE '{$prefix}%' ORDER BY id DESC LIMIT 1");
    $lastId = $stmt->fetchColumn();

    if ($lastId) {
        $num = intval(substr($lastId, strlen($prefix))) + 1;
    } else {
        $num = 1;
    }

    return $prefix . str_pad($num, 3, '0', STR_PAD_LEFT);
}

function tokenHeader()
{
    $headers = getallheaders();

    if (!isset($headers['Authorization']) || !preg_match('/Bearer\\s\\S+/', $headers['Authorization'])) {
        http_response_code(401);
        echo json_encode(['error' => 'Authorization token missing or malformed']);
        exit;
    }
}
