<?php

session_start();
ob_start();

require "dbconnect.php";

$sql = "SELECT * FROM student";

$result = mysqli_query($con, $sql);
$response = array();

while ($row = mysqli_fetch_array($result)) {
    array_push($response, array("id" => $row[0], "name" => $row[1], "age" => $row[2]));
}
echo json_encode($response);
$con->close();