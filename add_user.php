<?php

    include 'connect.php';

    $user_values = json_encode($_POST['user_values']);
    $data  = json_decode($user_values);
    
    //echo $data->username;
    $sql = mysqli_query($con , 
        //SQL CALL
        "CALL add_user('$data->username' , '$data->password', '$data->name', '$data->name', '$data->email', '$data->position')");
?>