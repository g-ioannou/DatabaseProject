<?php

include_once 'connect.php';

$user_values = json_encode($_POST['user_values']);//get a json object
$data = json_decode($user_values);

/*template

if(isset($data->)){
  $sql_ = mysqli_query($con, "CALL ('$data->name',)");
}
*/

//$sql = mysqli_query($con,"UPDATE company SET phone = '$data->phone' WHERE name ='$data->name'");

$sql = "";

if (isset($data->phone)) {
    $sql .=  "CALL new_company_phone('$data->name', $data->phone);";
}//procedure that inserts value of "phone" to the corresponding "name" row

if (isset($data->street)) {
    $sql .=  "CALL new_company_street('$data->name', '$data->street');";
}

if (isset($data->street_num)) {
    $sql  .=  "CALL new_company_street_num('$data->name' , $data->street_num);";
}

if(isset($data->city)){
    $sql .= "CALL new_company_city('$data->name', '$data->city');";
  }

  if(isset($data->country)){
    $sql .=  "CALL new_company_country('$data->name', '$data->country');";
  }

  /* execute multi query */
if (!mysqli_multi_query($con, $sql)) {
   echo "error"; 
}