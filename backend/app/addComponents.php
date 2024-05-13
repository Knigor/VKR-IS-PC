<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: http://localhost:5173');
header('Access-Control-Allow-Headers: Content-Type');
header('Access-Control-Allow-Methods: POST');

// Параметры подключения к базе данных
$host = 'postgres-db';
$dbname = 'vkr-2024';
$user = 'user';
$password = 'user';

$response = array();

// Установка соединения с базой данных
$dsn = "pgsql:host=$host;dbname=$dbname;user=$user;password=$password";
try {
    $db = new PDO($dsn);
    $response['status'] = 'success';
    $response['message'] = 'Соединение установлено';

    // Получение данных из POST-запроса
    $name_components = $_POST['name_components'];
    $id_category = $_POST['id_category'];
    $property_components = json_decode($_POST['property_components'], true); // Декодируем JSON строку в массив
    $img_components = $_FILES['img_components']; // Получаем информацию о загруженном файле
    

    // генирируем строку для вставки

    $values = "";


    foreach ($property_components as $component) {
        $value_property = $component['value'];
        $key_property = $component['key'];
        $values .= "('$value_property', '$key_property'), ";
    }

    $values = rtrim($values, ', ');


    // Чтение изображения и его представление в формате base64
    $srcFileName = $img_components['name']; // Исправлено на $img_components
    $newFilePath = __DIR__ . '/images/' . $srcFileName;

    $response['file_path'] = __DIR__ . '/images/' . $srcFileName;

    // Обработка загрузки файла
    if (move_uploaded_file($img_components['tmp_name'], $newFilePath)) {
        $response['file_url'] = 'http://localhost:5173/public/images/' . $srcFileName;
    } else {
        // Если возникла ошибка при загрузке файла, обработайте ее здесь
    }



    $response['name_components'] = $name_components;
    $response['id_category'] = $id_category;
    $response['property_components'] = $property_components;
    $response['image_components'] = $img_components['name'];



    $db->beginTransaction();

    $sql = "INSERT INTO componets (name_components, price_components, img_components)
        VALUES ('$name_components','0','$srcFileName');
    ";
    $db->exec($sql);

    $sql = "INSERT INTO stores_product (id_catergory, id_components)
        VALUES ('$id_category', (SELECT id_components FROM componets ORDER BY id_components DESC LIMIT 1));
    ";
    $db->exec($sql);

    $sql = "WITH inserted_properties AS (
            INSERT INTO property_components (value_property, key_property)
            VALUES 
                $values
            RETURNING id_property
        )
        INSERT INTO stores_property (id_property, id_components)
        SELECT id_property, (SELECT id_components FROM componets ORDER BY id_components DESC LIMIT 1)
        FROM inserted_properties;
    ";
    $db->exec($sql);

    // Завершить транзакцию
    $db->commit();
    
  //  echo "Транзакция успешно выполнена!";


   
    $db = null;
} catch (PDOException $e) {
    $response['status'] = 'error';
    $response['message'] = 'Ошибка: ' . $e->getMessage();
}

echo json_encode($response);
?>
