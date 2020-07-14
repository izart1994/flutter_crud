<?php
session_start();

if (isset($_SERVER['HTTP_ORIGIN'])) {
    header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
    header("Access-Control-Allow-Credentials: true");
    header('Access-Control-Max-Age: 86400');    // cache for 1 day
}

// Access-Control headers are received during OPTIONS requests
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))
        header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
    if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
        header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");
    exit(0);
}

require "dbconnect.php";

$data = file_get_contents("php://input");

if (isset($data)) {
    $request = json_decode($data);
    $name = $request->name;
    $age = $request->age;
}

$name = mysqli_real_escape_string($con, $name);
$age = mysqli_real_escape_string($con, $age);

$name = stripslashes($name);
$age = stripslashes($age);
//-----------------------------------------------------------------


$sql = "INSERT INTO student (name, age) VALUES ('$name', '$age')";

if ($con->query($sql) === TRUE) {
    $response = array("state" => "Successful", "detail" => "Berjaya.");
} else {
    $response = array("state" => "Unsuccessful", "detail" => "Tidak Berjaya.");
}

echo json_encode($response);
$con->close();
