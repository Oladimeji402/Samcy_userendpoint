<?php
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    echo json_encode(['status' => 'ok', 'message' => 'server endpoint is working']);
    exit;
}
