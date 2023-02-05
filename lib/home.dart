import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uas_mobile/editdata.dart';
import 'package:uas_mobile/tambahdata.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _listdata = [];
  Future _getdata() async {
    try {
      final respon =
          await http.get(Uri.parse('http://192.168.42.207/mtools/read.php'));
      if (respon.statusCode == 200) {
        // print(respon.body);
        final data = jsonDecode(respon.body);
        setState(() {
          _listdata = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _hapus(String ID_BARANG) async {
    try {
      final respon =
          await http.post(Uri.parse('http://192.168.42.207/mtools/delete.php'),
          body: {
            "ID_BARANG" : ID_BARANG,
          }
          );
      if (respon.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getdata();
    // print(_listdata);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: ListView.builder(
        itemCount: _listdata.length,
        itemBuilder: ((context, index) {
          return Card(
            child: InkWell(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => EditData(
                                ListData: {
                                  "ID_BARANG": _listdata[index]['ID_BARANG'],
                                  "NAMA_BARANG": _listdata[index]['NAMA_BARANG'],
                                  "STOK": _listdata[index]['STOK'],
                                },
                              ))));
                },
                child: ListTile(
                  title: Text(_listdata[index]['NAMA_BARANG']),
                  subtitle: Text("Stok: "+ _listdata[index]['STOK']),
                  trailing: 
                    IconButton(onPressed: (){
                      showDialog(context: context, 
                      builder: ((context) {
                        return AlertDialog(
                          content: Text("Yakin untuk menghapus?"),
                          actions: [
                            ElevatedButton(onPressed: (){
                              _hapus(_listdata[index]['ID_BARANG']).then((value) {
                                if (value) {
                              final snackBar = SnackBar(
                                content: Text('Data Berhasil dihapus!'),
                              );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            } else {
                              final snackBarError = SnackBar(
                                content: Text('Terjadi Kesalahan'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBarError);
                              }});
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) => Home())), (route) => false);
                            }, child: Text("Hapus")),
                            ElevatedButton(onPressed: (){
                              Navigator.of(context).pop();
                            }, child: Text("Batal"))
                          ],
                        );
                      }));
                    }, icon: Icon(Icons.delete))
                ,
                ),
              ),
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => TambahDataPage())));
        },
      ),
    );
  }
}
