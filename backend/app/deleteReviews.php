<?php

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: http://localhost:5173');
header('Access-Control-Allow-Headers: Content-Type');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Credentials: true');

try {
    $connectPDO = new PDO("pgsql:host=postgres-db;dbname=vkr-2024", "user", "user");
    $connectPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Получаем данные из POST запроса
    $idScore = $_POST['id_score'] ?? '';

    
    // Готовим SQL-запрос
    $stmt = $connectPDO->prepare("DELETE from review 
                                    where id_score = :id_score");

    // Подставляем значение id_components в запрос
    $stmt->bindParam(':id_score', $idScore, PDO::PARAM_STR);


    // Выполняем запрос
    $stmt->execute();
    
    // Проверяем успешность операции и отправляем соответствующий JSON
    if ($stmt->rowCount() > 0) {
        echo json_encode(['status' => 'Success', 'message' => 'Успешно отправлено']);
    } else {
        echo json_encode(['status' => 'Error', 'message' => 'Ошибка отправки']);
    }

} catch (PDOException $e) {
    echo json_encode(['error' => 'Ошибка подключения к базе данных: ' . $e->getMessage()]);
}

?>
