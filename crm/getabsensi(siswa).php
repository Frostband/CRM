<?php
    include 'conn.php';

    $mapel = $_POST['nama_mapel'];
    $kelas = $_POST['nama_kelas'];

    $sql = "SELECT s.nama, COUNT(p.id_pertemuan) AS `absensi` 
            FROM siswa s, pertemuan p, mapel m, kelas k 
            WHERE s.id_siswa = p.id_siswa 
            AND m.id_mapel = p.id_mapel 
            AND m.nama_mapel = '$mapel'
            AND k.nama_kelas = '$kelas'
            GROUP BY s.nama";
    
   

    $queryResult = $connect->query($sql);
    $userRecord = array();
    if($queryResult->num_rows > 0){

        while($rowFound = $queryResult->fetch_assoc()){
            $userRecord[] = $rowFound;
        }

        echo json_encode($userRecord);
    } 
?>