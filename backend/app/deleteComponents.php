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

    $connectPDO->beginTransaction();

    // Удаляем записи из stores_product
    $stmt1 = $connectPDO->prepare("DELETE FROM stores_product WHERE id_components = :id_score");
    $stmt1->bindParam(':id_score', $idScore, PDO::PARAM_STR);
    $stmt1->execute();

    // Удаляем записи из stores_property
    $stmt2 = $connectPDO->prepare("DELETE FROM stores_property WHERE id_components = :id_score");
    $stmt2->bindParam(':id_score', $idScore, PDO::PARAM_STR);
    $stmt2->execute();

    // Удаляем записи из componets
    $stmt3 = $connectPDO->prepare("DELETE FROM componets WHERE id_components = :id_score");
    $stmt3->bindParam(':id_score', $idScore, PDO::PARAM_STR);
    $stmt3->execute();

    // Фиксируем изменения в базе данных
    $connectPDO->commit();
    
    // Проверяем успешность операции и отправляем соответствующий JSON
    echo json_encode(['status' => 'Success', 'message' => 'Успешно отправлено']);

} catch (PDOException $e) {
    // Отменяем изменения в случае ошибки
    $connectPDO->rollBack();
    echo json_encode(['error' => 'Ошибка подключения к базе данных: ' . $e->getMessage()]);
}

?>
