import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailSiswa extends StatefulWidget {
  const DetailSiswa({Key? key}) : super(key: key);

  @override
  State<DetailSiswa> createState() => _DetailSiswaState();
}
//belum selesai
class _DetailSiswaState extends State<DetailSiswa> {

  String NamaKelas = "";
  String NamaMapel = "";
  List<Map<String,dynamic>> data = [

  ];

  Future<List<dynamic>> getAbsenSiswa() async {
    final response = await http.post(
      Uri.parse("http://10.0.2.2/crm/getabsensi(siswa)data.php"),
      body: {
        "nama_kelas": NamaKelas,
        "nama_mapel": NamaMapel,
      }
      );
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    
    dynamic dataKelas = ModalRoute.of(context)!.settings.arguments;
    
    NamaKelas = dataKelas['nama_kelas'].toString();
    NamaMapel = dataKelas['nama_mapel'].toString();
    final columns = ['Nama','Absensi','Nilai'];
    List<DataColumn> getColumns(List<String> columns) => columns.map((String column) => DataColumn(label: Text(column),)).toList();

    return Scaffold(
      appBar: AppBar(title: Text("Detail Kelas")),
      body: Container(
        padding:  EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(NamaKelas),
            Text(NamaMapel),
            Text("Daftar Siswa"),
            DataTable(columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text('Name',
                    style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
              'Age',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Role',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ], rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Sarah')),
            DataCell(Text('19')),
            DataCell(Text('Student')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Janine')),
            DataCell(Text('43')),
            DataCell(Text('Professor')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('William')),
            DataCell(Text('27')),
            DataCell(Text('Associate Professor')),
          ],)
          ],
        ),
      ]
      )
    )
    );
  }
}