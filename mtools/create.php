<?php
$conn = new mysqli ("localhost", "root", "","mtools");
$NAMA_BARANG = $_POST["NAMA_BARANG"];
$STOK = $_POST["STOK"];
$data = mysqli_query($conn, "INSERT INTO barang SET ID_BARANG='', NAMA_BARANG='$NAMA_BARANG', STOK='$STOK'");
if ($data) {
    echo json_encode([
        'Pesan' => 'Data berhasil ditambahkan']);
}else {
    echo json_encode([
        'Pesan' => 'Terjadi kesalahan'
    ]);
}

?>