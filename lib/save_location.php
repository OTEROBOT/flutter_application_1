<?php
header('Content-Type: application/json; charset=UTF-8');

// ข้อมูลการเชื่อมต่อฐานข้อมูล (จาก get_location.php)
$servername = "localhost";
$username = "its66040233110";
$password = "H5mbS4C8";
$dbname = "its66040233110";

// สร้างการเชื่อมต่อ
$conn = new mysqli($servername, $username, $password, $dbname);

// ตรวจสอบการเชื่อมต่อ
if ($conn->connect_error) {
    echo json_encode(["success" => false, "error" => "การเชื่อมต่อล้มเหลว: " . $conn->connect_error]);
    exit;
}

// ตั้งค่าการเข้ารหัสเพื่อรองรับภาษาไทย
$conn->set_charset("utf8mb4");

// รับข้อมูลจาก Flutter
$name = isset($_POST['name']) ? $_POST['name'] : '';
$latitude = isset($_POST['latitude']) ? $_POST['latitude'] : '';
$longitude = isset($_POST['longitude']) ? $_POST['longitude'] : '';

// ตรวจสอบว่าข้อมูลครบถ้วนหรือไม่
if (empty($name) || empty($latitude) || empty($longitude)) {
    echo json_encode(["success" => false, "error" => "ข้อมูลไม่ครบถ้วน"]);
    $conn->close();
    exit;
}

// เตรียมคำสั่ง SQL
$sql = "INSERT INTO locations (name, latitude, longitude) VALUES (?, ?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("sss", $name, $latitude, $longitude);

// ดำเนินการบันทึกและส่งผลลัพธ์
if ($stmt->execute()) {
    echo json_encode(["success" => true]);
} else {
    echo json_encode(["success" => false, "error" => "บันทึกข้อมูลล้มเหลว: " . $conn->error]);
}

// ปิดการเชื่อมต่อ
$stmt->close();
$conn->close();
?>