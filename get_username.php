<?php
    session_start();
    include_once 'connect.php';
    echo $_SESSION['username'];

?>