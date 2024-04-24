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
    $stmt = $connectPDO->prepare("SELECT pc.*, c.id_components 
                                  FROM property_components pc 
                                  INNER JOIN stores_property sp ON pc.id_property = sp.id_property
                                  INNER JOIN componets c ON sp.id_components = c.id_components 
                                  WHERE c.id_components = :id_components");

    // Подставляем значение id_components в запрос
    $stmt->bindParam(':id_components', $idComponents, PDO::PARAM_STR);

    // Выполняем запрос
    $stmt->execute();

    // Получаем результат в виде ассоциативного массива
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Выводим результат в формате JSON
    echo json_encode($result);

} catch (PDOException $e) {
    echo json_encode(['error' => 'Ошибка подключения к базе данных: ' . $e->getMessage()]);
}

?>
