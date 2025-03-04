<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

$host = "localhost";
$user = "its66040233110";
$password = "H5mbS4C8";
$dbname = "its66040233110";

$conn = new mysqli($host, $user, $password, $dbname);

if ($conn->connect_error) {
    die(json_encode(array("message" => "Connection failed: " . $conn->connect_error)));
}

$data = json_decode(file_get_contents("php://input"), true);

$id = isset($_POST['id']) ? $_POST['id'] : '';
$title = isset($_POST['title']) ? $_POST['title'] : '';
$description = isset($_POST['description']) ? $_POST['description'] : '';

if (empty($id) || empty($title) || empty($description)) {
    echo json_encode(array("message" => "ID, title, and description are required"));
    exit();
}

$sql = "UPDATE tasks SET title='$title', description='$description' WHERE id='$id'";
if ($conn->query($sql) === TRUE) {
    echo json_encode(array("message" => "Task updated successfully"));
} else {
    echo json_encode(array("message" => "Error: " . $conn->error));
}

$conn->close();
?>