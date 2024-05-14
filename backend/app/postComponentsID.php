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
    $stmt = $connectPDO->prepare("SELECT c.*, cp.name_category
                                    FROM componets c
                                    INNER JOIN stores_product sp ON c.id_components = sp.id_components 
                                    INNER JOIN category_product cp ON sp.id_catergory = cp.id_catergory
                                    where c.id_components = :id_components
                                    ORDER BY c.id_components asc;");

    // Подставляем значение id_components в запрос
    $stmt->bindParam(':id_components', $idComponents, PDO::PARAM_STR);
    // Выполняем запрос
    $stmt->execute();

    $stm2 = $connectPDO->prepare("SELECT pc.*, c.id_components
                                    from property_components pc 
                                    inner join stores_property sp on pc.id_property = sp.id_property
                                    inner join componets c on sp.id_components = c.id_components
                                    where sp.id_components = :id_components
                                    order by pc.id_property ASC");

    $stm2->bindParam(':id_components', $idComponents, PDO::PARAM_STR);

    // Выполняем второй запрос
    $stm2->execute();

    // Получаем результаты обоих запросов в виде ассоциативных массивов
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    $result2 = $stm2->fetchAll(PDO::FETCH_ASSOC);

    // Объединяем результаты обоих запросов в один массив
    $combinedResult = array(
        'components' => $result,
        'properties' => $result2
    );

    // Выводим результат в формате JSON
    echo json_encode($combinedResult);

} catch (PDOException $e) {
    echo json_encode(['error' => 'Ошибка подключения к базе данных: ' . $e->getMessage()]);
}

?>
