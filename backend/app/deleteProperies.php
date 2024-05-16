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
    $idProperty = $_POST['id_property'] ?? '';


    $connectPDO->beginTransaction();

    // Удаляем записи из stores_product
    $stmt1 = $connectPDO->prepare("DELETE from stores_property 
                                    where id_property = :id_property");
    $stmt1->bindParam(':id_property', $idProperty);
    $stmt1->execute();

    $stmt2 = $connectPDO->prepare("DELETE from property_components
                                    where id_property = :id_property");
    $stmt2->bindParam(':id_property', $idProperty);
    $stmt2->execute();


    // Фиксируем изменения в базе данных
    $connectPDO->commit();
    
    // Проверяем успешность операции и отправляем соответствующий JSON
    echo json_encode(['status' => 'Success', 'message' => 'Успешно удалено']);

} catch (PDOException $e) {
    // Отменяем изменения в случае ошибки
    $connectPDO->rollBack();
    echo json_encode(['error' => 'Ошибка подключения к базе данных: ' . $e->getMessage()]);
}

?>
