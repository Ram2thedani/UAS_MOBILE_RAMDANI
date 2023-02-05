import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uas_mobile/home.dart';

class TambahDataPage extends StatefulWidget {
  const TambahDataPage({super.key});

  @override
  State<TambahDataPage> createState() => _TambahDataPageState();
}

class _TambahDataPageState extends State<TambahDataPage> {
  final formKey = GlobalKey<FormState>();
  // TextEditingController ID_BARANG = TextEditingController();
  TextEditingController NAMA_BARANG = TextEditingController();
  TextEditingController STOK = TextEditingController();
  Future _simpan() async {
    final respon = await http
        .post(Uri.parse('http://192.168.42.207/mtools/create.php'), body: {
      // "ID_BARANG": ID_BARANG.text,
      "NAMA_BARANG": NAMA_BARANG.text,
      "STOK": STOK.text,
    });
    if (respon.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tambah data barang"),
        ),
        body: Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  // TextFormField(
                  //   controller: ID_BARANG,
                  //   decoration: InputDecoration(
                  //     hintText: "ID_BARANG",
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //   ),
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return "Wajib diisi";
                  //     }
                  //   },
                  // ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: NAMA_BARANG,
                    decoration: InputDecoration(
                      hintText: "NAMA BARANG",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Wajib diisi";
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: STOK,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "STOK",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Wajib diisi";
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          _simpan().then((value) {
                            if (value) {
                              final snackBar = SnackBar(
                                content: Text('Data Berhasil ditambahkan!'),
                              );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            } else {
                              final snackBarError = SnackBar(
                                content: Text('Terjadi Kesalahan'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBarError);
                            }
                          });
                           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) => Home())), (route) => false);
                        }
                      },
                      child: Text("Simpan")),
                     
                ],
              ),
            )));
  }
}
