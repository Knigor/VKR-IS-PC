<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $host = 'postgres-db';
    $dbname = 'vkr-2024';
    $user = 'user';
    $password = 'user';
    $port = '5432';

    try {
        $pdo = new PDO("pgsql:host=$host;port=$port;dbname=$dbname", $user, $password);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch (PDOException $e) {
        die("Ошибка подключения к базе данных: " . $e->getMessage());
    }


    $query = $pdo->query(
    "SELECT r.id_score, u.fio , r.text_review, r.id_components, r.checkreview
    from review r
    inner join users u on r.id_user = u.id_user 
    where r.checkreview = false");
    $data = $query->fetchAll(PDO::FETCH_ASSOC);
    
    // Выводим данные в формате JSON
    header('Content-Type: application/json');
    echo json_encode($data);
} else {
    echo json_encode(['error' => 'Only GET requests are allowed']);
}
?>
