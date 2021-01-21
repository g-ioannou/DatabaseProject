<?php 

include 'connect.php';

$user_values = json_encode($_POST['user_values']);
$data = json_decode($user_values);


$sql= mysqli_query($con ,"CALL get_user('$data->username')");
$rows = mysqli_num_rows($sql);
$row = mysqli_fetch_array($sql);

if ($rows==1){
    echo "exists";
}