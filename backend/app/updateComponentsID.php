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
    $json = file_get_contents('php://input');
    $data = json_decode($json, true); // Преобразуем JSON в ассоциативный массив

    // Здесь вы можете обрабатывать полученные данные
    // Например, вы можете вывести их на экран

   // $data['status'] = 'success';

    echo json_encode($data),"\n";

  //  $output['status'] = 'success';

  //  echo json_encode($output);

  


  foreach ($data as $item) {
    $id_property = $item['id_property'];
    $valueProperty = $item['value_property'];
    $keyProperty = $item['key_property'];
    $id_components = $item['id_components'];

    echo "id Компонента  $id_components \n";
    echo "Значение  $id_property \n";
    echo "Значение  $valueProperty \n";
    echo "Значение  $keyProperty \n";

    // Проверяем, существует ли id_property в базе данных
    $stmt = $connectPDO->prepare("SELECT COUNT(*) FROM property_components WHERE id_property = :id_property");
    $stmt->bindParam(':id_property', $id_property);
    $stmt->execute();
    $count = $stmt->fetchColumn();

    if ($count > 0) {
        // id_property существует в базе данных
        // Ваша логика для этого случая
     //   echo json_encode(['status' => 'success', 'message' => 'Данные обновлены в таблице']);

        $stmUpdate = $connectPDO->prepare("UPDATE property_components pc
                                            set value_property = :value_property, key_property = :key_property 
                                            where id_property = :id_property");
        $stmUpdate->bindParam(':id_property',$id_property);                                    
        $stmUpdate->bindParam(':value_property',$valueProperty);                                    
        $stmUpdate->bindParam(':key_property',$keyProperty); 
        
        $stmUpdate->execute();

    } else {
        // id_property не существует в базе данных
        // Ваша логика для этого случая
      //  echo json_encode(['status' => 'error', 'message' => 'Данные добавлены в таблицу']);

      $stmInsert = $connectPDO->prepare("WITH inserted_id AS (
        INSERT INTO property_components (value_property, key_property)
        VALUES (:value_property, :key_property)
        RETURNING id_property
    )
    INSERT INTO stores_property (id_property, id_components)
    SELECT id_property, :id_components FROM inserted_id");
    
    $stmInsert->bindParam(':id_components', $id_components);                            
    $stmInsert->bindParam(':value_property', $valueProperty);                                    
    $stmInsert->bindParam(':key_property', $keyProperty);                                     
    
    $stmInsert->execute();
    }
}

   

} catch (PDOException $e) {
    echo json_encode(['error' => 'Ошибка подключения к базе данных: ' . $e->getMessage()]);
}

?>
