<?php

session_start();
include_once 'connect.php';
$user_values = json_encode($_POST['user_values']);
$data  = json_decode($user_values);

$sql = mysqli_query($con, "CALL identify_user('$data->username' , '$data->password')");
$query_rows = mysqli_num_rows($sql);
$row = mysqli_fetch_array($sql);

if ($query_rows == 1) {
    $_SESSION['username'] = $row['username'];
    echo $row['user_type'];
} else {
    echo 'fail';
}