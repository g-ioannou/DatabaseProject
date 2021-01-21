<?php

session_start();
include_once 'connect.php';

$username = $_SESSION['username'];

$sql= mysqli_query($con, "CALL increment_login('$username')");
$row = mysqli_fetch_assoc($sql);
echo $row['timesLoggedIn'];
//echo $row;