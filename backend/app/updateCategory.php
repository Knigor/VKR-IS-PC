<?php

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: http://localhost:5173');
header('Access-Control-Allow-Headers: Content-Type');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Credentials: true');

try {
    $connectPDO = new PDO("pgsql:host=postgres-db;dbname=vkr-2024", "user", "user");
    $connectPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $category = $_POST['id_category'];
    $idComponents = $_POST['id_components'];
    

    $stm = $connectPDO->prepare("UPDATE stores_product
                                set id_catergory = :id_category
                                where id_components = :id_components");




    $stm->bindParam(':id_category', $category);
    $stm->bindParam(':id_components', $idComponents);

    $stm->execute();


    echo json_encode(['status' => 'Success']);

   

} catch (PDOException $e) {
    echo json_encode(['error' => 'Ошибка подключения к базе данных: ' . $e->getMessage()]);
}

?>
