<?php

session_start();
include_once 'connect.php';

$username = $_SESSION['username'];

$sql = mysqli_query($conn , "CALL increment_login()");