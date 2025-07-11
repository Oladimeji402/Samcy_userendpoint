<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

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

function sendMail($to, $name, $subject, $htmlBody, $altBody = '')
{
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
        $mail->addAddress($to, $name);
        $mail->addReplyTo($_ENV['MAIL_FROM'], 'Samcy Support');

        $mail->isHTML(true);
        $mail->Subject = $subject;
        $mail->Body    = $htmlBody;
        $mail->AltBody = $altBody ?: strip_tags($htmlBody);

        $mail->send();
        return true;
    } catch (Exception $e) {
        error_log("Failed to send email to $to: " . $mail->ErrorInfo);
        return false;
    }
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

// $newId = generateCustomId('offer/2025/', $pdo, 'program_offerings', 'id');

function departmentToId($name)
{
    $map = [
        'science' => 1,
        'art' => 2,
        'commercial' => 3
    ];
    return $map[$name] ?? 0;
}

function generateCustomId($pdo, $table, $prefix)
{
    $year = date('Y');
    $pattern = "$prefix/$year/%";

    $stmt = $pdo->prepare("SELECT id FROM $table WHERE id LIKE ? ORDER BY id DESC LIMIT 1");
    $stmt->execute([$pattern]);
    $lastId = $stmt->fetchColumn();

    if ($lastId) {
        $lastNumber = (int)substr($lastId, strrpos($lastId, '/') + 1);
        $nextNumber = $lastNumber + 1;
    } else {
        $nextNumber = 1;
    }

    $formattedNumber = str_pad($nextNumber, 3, '0', STR_PAD_LEFT);
    return "$prefix/$year/$formattedNumber";
}
