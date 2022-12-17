<?php
    include 'conn.php';

    $nama = $_POST['nama'];

    $sql = "SELECT * FROM notif";

    $queryResult = $connect->query($sql);
    $userRecord = array();
    if($queryResult->num_rows > 0){

        while($rowFound = $queryResult->fetch_assoc()){
            $userRecord[] = $rowFound;
        }

        echo json_encode($userRecord);
    } 
?>