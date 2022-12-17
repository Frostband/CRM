<?php
include 'conn.php';

$username = $_POST['username'];
$password = $_POST['password'];

$sql = "SELECT id_role FROM user WHERE username = '$username' AND `password` = '$password'";

$queryResult = $connect->query($sql);
$userRecord = array();
if($queryResult->num_rows > 0){

    /*while($fetchData = $queryResult->fetch_assoc()){
        //print_r($fetchData);
        $result[] = $fetchData;
    }
    echo json_encode($result);*/

    while($rowFound = $queryResult->fetch_assoc()){
        $userRecord[] = $rowFound;
    }

    echo json_encode($userRecord);
}
?>