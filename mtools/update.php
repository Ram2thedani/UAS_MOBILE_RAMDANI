<?php
$conn = new mysqli ("localhost", "root", "","mtools");
$ID_BARANG = $_POST["ID_BARANG"];
$NAMA_BARANG = $_POST["NAMA_BARANG"];
$STOK = $_POST["STOK"];
$data = mysqli_query($conn, "UPDATE barang SET NAMA_BARANG='$NAMA_BARANG', STOK='$STOK' WHERE ID_BARANG='$ID_BARANG'");
if ($data) {
    echo json_encode([
        'Pesan' => 'Data berhasil diupdate']);
}else {
    echo json_encode([
        'Pesan' => 'Terjadi kesalahan'
    ]);
}

?>