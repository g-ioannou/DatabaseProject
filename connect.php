<?php

$hostname = 'localhost';
$username = 'root';
$password = '';
$database_name = 'staffevaluation';
 $con = mysqli_connect($hostname,$username,$password,$database_name);

 //Check connection
if (mysqli_connect_errno()) {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  exit();
}


?>