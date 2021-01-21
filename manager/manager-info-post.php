<?php

session_start();
include_once '../connect.php';

$managerInfo = json_encode($_POST['managerInfo']);
$data = json_decode($managerInfo);

$username = $_SESSION['username'];
echo $username;

$sql=mysqli_query($con, "CALL manager_info('$username','$data->managerCompany','$data->managerExperience')");