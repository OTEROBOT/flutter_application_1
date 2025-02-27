<?php
header('Content-Type: application/json; charset=UTF-8');

$servername = "localhost";
$username = "its66040233110";
$password = "H5mbS4C8";
$dbname = "its66040233110";

// สร้างการเชื่อมต่อ
$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die(json_encode(["success" => false, "error" => "การเชื่อมต่อล้มเหลว: " . $conn->connect_error]));
}

$conn->set_charset("utf8mb4");

// ดึงข้อมูลจากตาราง locations
$sql = "SELECT id, name, latitude, longitude FROM locations";
$result = $conn->query($sql);

$locations = [];
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $locations[] = $row;
    }
    echo json_encode($locations);
} else {
    echo json_encode([]); // ถ้าไม่มีข้อมูล ส่ง JSON ว่างกลับไป
}

$conn->close();
?>
