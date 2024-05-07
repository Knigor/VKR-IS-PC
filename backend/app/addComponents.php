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


    // отправим файл на frontend


    // Подготовка SQL запроса для добавления атрибутов в сущность "subject"
    // $sql = "INSERT INTO subject (name_item, faculty, class, foto, id_user) VALUES (:name_item, :faculty, :class, :foto, :id_user)";
    // $stmt = $db->prepare($sql);

    // // Выполнение запроса с параметрами
    // $stmt->bindParam(':name_item', $name_item);
    // $stmt->bindParam(':faculty', $faculty);
    // $stmt->bindParam(':class', $class);
    // $stmt->bindParam(':foto', $foto_base64);
    // $stmt->bindParam(':id_user', $id_user);
    
    // if ($stmt->execute()) {
    //     $response['status'] = 'success';
    //     $response['message'] = 'Данные успешно добавлены';
    // } else {
    //     $response['status'] = 'error';
    //     $response['message'] = 'Ошибка при выполнении запроса';
    // }

    // Закрытие соединения с базой данных
    $db = null;
} catch (PDOException $e) {
    $response['status'] = 'error';
    $response['message'] = 'Ошибка: ' . $e->getMessage();
}

echo json_encode($response);
?>
