<?php

header('Access-Control-Allow-Origin: http://localhost:5173');
header('Access-Control-Allow-Headers: Content-Type');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Credentials: true');

session_start();

// Подключение к базе данных
$pdo = new PDO("pgsql:host=postgres-db; dbname=vkr-2024", "user", "user");

if ($_SERVER["REQUEST_METHOD"] == "POST" && !empty($_POST)) {
    $login = $_POST["login"] ?? '';
    $password = $_POST["password"] ?? '';

    if (!empty($login) && !empty($password)) {
        // Проверка логина и пароля в базе данных
        $stmt = $pdo->prepare("SELECT * FROM users WHERE login = ?");
        $stmt->execute([$login]);
        $user = $stmt->fetch();

        if ($user && hash('sha256', $password) === $user['hash_password']) {
            // Успешная аутентификация
            $_SESSION["user"] = $user;
            
            // Добавляем выборку роли и ФИО пользователя
            $role = $user['role'];
            $fullName = $user['fio'];
            $email = $user['email'];
            
            // Отправка JSON-ответа с ФИО пользователя
            header('Content-Type: application/json');
            echo json_encode(array('status' => 'success', 'id_user' => $user['id_user'], 'role' => $role, 'full_name' => $fullName, 'email' => $email));
            exit();
        } else {
            // Ошибка авторизации
            header('Content-Type: application/json');
            echo json_encode(array('status' => 'error', 'message' => 'Неверное имя пользователя или пароль.'));
            exit();
        }
    } else {
        // Пустые данные в POST-запросе
        header('Content-Type: application/json');
        echo json_encode(array('status' => 'error', 'message' => 'Поля логина и пароля должны быть заполнены.'));
        exit();
    }
}



?>