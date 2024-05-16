<?php

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: http://localhost:5173');
header('Access-Control-Allow-Headers: Content-Type');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Credentials: true');

try {
    $connectPDO = new PDO("pgsql:host=postgres-db;dbname=vkr-2024", "user", "user");
    $connectPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $img_components = $_FILES['img_components'];
    $idComponents = $_POST['id_components'];

    // print_r($img_components);


    $newFilePath = __DIR__ . '/images/' . $img_components['name'];
   
    
  
    // Обработка загрузки файла
    if (move_uploaded_file($img_components['tmp_name'], $newFilePath)) {
      //  echo json_encode(['Cтатус файла' => 'Файл успешно загружен']);
    } else {
        echo json_encode(['Cтатус файла' => 'Произошла ошибка при загрузке файла']);
    }

    

    $stm = $connectPDO->prepare("UPDATE componets 
                                set img_components = :img_components
                                where id_components = :id_components");




    $stm->bindParam(':img_components', $img_components['name']);
    $stm->bindParam(':id_components', $idComponents);

    $stm->execute();

    
    echo json_encode(['Status' => 'Success']);    
   

} catch (PDOException $e) {
    echo json_encode(['error' => 'Ошибка подключения к базе данных: ' . $e->getMessage()]);

}

?>
