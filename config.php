<?php
// Database configuration
$db_host = '34.88.52.110';
$db_name = 'image_catalog';
$db_user = 'appmod-phpapp-user';
$db_pass = 'kFdZB-z+NizpXF1';

try {
    $pdo = new PDO("mysql:host=$db_host;dbname=$db_name", $db_user, $db_pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Connection error: " . $e->getMessage());
}

session_start();
?>
