<?php

    $servername = "localhost";
    $databasename = "flutter_test";
    $username = "root";
    $password = "124578";

    $con = mysqli_connect($servername,$username,$password,$databasename);

    if( !$con){
        die("Error in connection " . mysqli_connect_error());
    }

    // include_once('set_timezone.php');
?>