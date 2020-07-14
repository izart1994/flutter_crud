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
    $id = $request->id;
    $name = $request->name;
    $age = $request->age;
}

$id = mysqli_real_escape_string($con, $id);
$name = mysqli_real_escape_string($con, $name);
$age = mysqli_real_escape_string($con, $age);

$id = stripslashes($id);
$name = stripslashes($name);
$age = stripslashes($age);
//-----------------------------------------------------------------

$sql = "UPDATE student SET name='" . $name . "', age='" . $age . "' WHERE id='" . $id . "'";

$result = mysqli_query($con, $sql);

if ($result) {
    //echo "Record was updated successfully.";
    $response = array("state" => "Successful");
} else {
    //echo "ERROR: Could not able to execute.";
    $response = array("state" => "Unsuccessful");
}

echo json_encode($response);
$con->close();
