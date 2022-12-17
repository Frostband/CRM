import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class cek_tugas extends StatefulWidget {
  const cek_tugas({super.key});

  @override
  State<cek_tugas> createState() => _cek_tugasState();
}

class _cek_tugasState extends State<cek_tugas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
          child: ListView(children: <Widget>[
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Pengaturan'),
          onTap: () {
            Navigator.pushNamed(context, 'Pengaturan');
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('LogOut'),
          onTap: () {
            Navigator.pushNamed(context, 'LogOut');
          },
        ),
      ])),
      appBar: AppBar(title: Text("School Center App")),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 5, bottom: 20, right: 20, top: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Kelas 12 A'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Matematika'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 5, bottom: 20, right: 20, top: 10),
              child: TextField(
                decoration: InputDecoration(
                    labelText: "Deskripsi Tugas",
                    hintText: "Tampilkan Deskripsi Tugas",
                    ),
                    readOnly: true,
              ),
              
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 5, bottom: 20, right: 20, top: 10),
              child: TextField(
                decoration: InputDecoration(
                    labelText: "Tenggat Waktu",
                    hintText: "Tenggat Pada tanggal",
                    ),
                    readOnly: true,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: Text("Kembali"),
                onPressed: () {
                  Navigator.pushNamed(context, '/detail');
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
