import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uas_mobile/editdata.dart';
import 'package:uas_mobile/tambahdata.dart';

class DummyHome extends StatefulWidget {
  const DummyHome({super.key});

  @override
  State<DummyHome> createState() => _DummyHomeState();
}

class _DummyHomeState extends State<DummyHome> {
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
        title: Text("Home"),
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
                                  "RFID": _listdata[index]['RFID'],
                                  "NAMA": _listdata[index]['NAMA'],
                                  "KELAS": _listdata[index]['KELAS'],
                                },
                              ))));
                },
                child: ListTile(
                  title: Text(_listdata[index]['NAMA']),
                  subtitle: Text(_listdata[index]['KELAS']),
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
