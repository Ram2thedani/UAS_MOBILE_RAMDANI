<?php
$conn = new mysqli ("localhost", "root", "","mtools");
$ID_BARANG = $_POST["ID_BARANG"];
$data = mysqli_query($conn, "DELETE FROM barang WHERE ID_BARANG='$ID_BARANG'");
if ($data) {
    echo json_encode([
        'Pesan' => 'Data berhasil dihapus']);
}else {
    echo json_encode([
        'Pesan' => 'Terjadi kesalahan'
    ]);
}

?>