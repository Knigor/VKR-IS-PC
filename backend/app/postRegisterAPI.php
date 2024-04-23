<?php

header('Access-Control-Allow-Origin: http://localhost:5173');
header('Access-Control-Allow-Headers: Content-Type');
header('Access-Control-Allow-Methods: POST');

$pdo = new PDO("pgsql:host=postgres-db; dbname=vkr-2024", "user", "user");

$login = $_POST["login"] ?? '';
$fio = $_POST["fio"] ?? '';
$password = $_POST["password"] ?? '';
$email = $_POST["email"] ?? '';

// Валидация данных (простая валидация)
if (empty($login) || empty($password) || empty($fio)) {
    header('Content-Type: application/json');
    echo json_encode(array('status' => 'error', 'message' => 'Заполните все поля.'));
    exit();
}

if (empty($email)) {
    header('Content-Type: application/json');
    echo json_encode(array('status' => 'errorEmail', 'message' => 'Почтовый адрес не указан.'));
    exit();
}

// Проверка уникальности логина
$stmtLogin = $pdo->prepare("SELECT * FROM users WHERE login = ?");
$stmtLogin->execute([$login]);
$userLogin = $stmtLogin->fetch();

if ($userLogin) {
    header('Content-Type: application/json');
    echo json_encode(array('status' => 'errorLogin', 'message' => 'Пользователь с таким логином уже существует'));
    exit();
}

// Проверка уникальности email
$stmtEmail = $pdo->prepare("SELECT * FROM users WHERE email = ?");
$stmtEmail->execute([$email]);
$userEmail = $stmtEmail->fetch();

if ($userEmail) {
    header('Content-Type: application/json');
    echo json_encode(array('status' => 'errorEmail', 'message' => 'Пользователь с такой почтой уже существует.'));
    exit();
}

// Хеширование пароля
$hashedPassword = hash('sha256', $password);

// Подготовка данных для вставки в таблицу users
$data = [
    'login' => $login,
    'hashedPassword' => $hashedPassword,
    'full_name_user' => $fio,
    'email' => $email,
    'role_user' => 'User',
];

$stmtInsert = $pdo->prepare("INSERT INTO users (email, fio, hash_password, login, role) VALUES (:email, :full_name_user, :hashedPassword, :login, :role_user)");
$stmtInsert->execute($data);

// Получение id новой записи
$id_user = $pdo->lastInsertId();

// Добавление id_user к данным
$data['id_user'] = $id_user;

// Запись данных в файл (для отладки)
$userDataString = json_encode(array('status' => 'success', 'user' => $data));
file_put_contents('dataa.txt', $userDataString . PHP_EOL, FILE_APPEND);

// Формирование и отправка JSON-ответа
header('Content-Type: application/json');
echo $userDataString;
exit();

?>
