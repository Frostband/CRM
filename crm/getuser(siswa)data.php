<?php
    include 'conn.php';

    $nama = $_POST['nama'];

    $sql = "SELECT k.nama_kelas, m.nama_mapel 
            FROM kelas k, mapel m, kelas_siswa l, siswa s 
            WHERE k.id_kelas = l.id_kelas 
            AND m.id_mapel = l.id_mapel 
            AND l.id_siswa = s.id_siswa 
            AND s.id_siswa = (SELECT id_siswa FROM siswa WHERE nama = '$nama')";

    $queryResult = $connect->query($sql);
    $userRecord = array();
    if($queryResult->num_rows > 0){

        while($rowFound = $queryResult->fetch_assoc()){
            $userRecord[] = $rowFound;
        }

        echo json_encode($userRecord);
    } 
?>