<?php

session_start();
include_once 'connect.php';

$username = $_SESSION['username'];
$result = [];
$sql = mysqli_query($conn , "CALL increment_login()");