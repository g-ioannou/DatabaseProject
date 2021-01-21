<?php


include_once "../connect.php";

$result = [];
$sql= mysqli_query($con, 'CALL show_companies()');
  while($row = mysqli_fetch_array($sql)){
    $result[] = $row['name'];
  }

  echo json_encode($result);