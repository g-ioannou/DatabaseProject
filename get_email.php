<?php

session_start();
include 'connect.php';

$username = $_SESSION['username'];


 $sql= mysqli_query($con ,"CALL get_email('$username')");
 $row = mysqli_fetch_assoc($sql);
 echo $row['email'];