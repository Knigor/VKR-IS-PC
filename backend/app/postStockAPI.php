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
    $idComponents = $_POST['id_components'] ?? '';

    // Готовим SQL-запрос
    $stmt = $connectPDO->prepare("SELECT cs.quantity_stock 
                                    from components_stock cs
                                    where id_components = :id_components");

    // Подставляем значение id_components в запрос
    $stmt->bindParam(':id_components', $idComponents, PDO::PARAM_STR);

    // Выполняем запрос
    $stmt->execute();

    // Получаем результат в виде ассоциативного массива
    $result = $stmt->fetch(PDO::FETCH_ASSOC);

    // Выводим результат в формате JSON
    echo json_encode($result);

} catch (PDOException $e) {
    echo json_encode(['error' => 'Ошибка подключения к базе данных: ' . $e->getMessage()]);
}

?>
