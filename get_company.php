<?php 

session_start();
include 'connect.php';

$result = array();
$username = $_SESSION['username'];
$sql= mysqli_query($con ,"CALL get_company('$username')");

while($row = mysqli_fetch_assoc($sql)){
    $result[]=$row;
}

header('Content-Type: application/json');
echo json_encode(($result));