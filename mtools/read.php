<?php
$conn = new mysqli ("localhost", "root", "","mtools");
$query = mysqli_query($conn, "SELECT * FROM barang");
$data = mysqli_fetch_all($query, MYSQLI_ASSOC);
echo json_encode($data);
?>