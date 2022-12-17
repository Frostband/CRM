import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailGuru extends StatefulWidget {
  const DetailGuru({Key? key}) : super(key: key);

  @override
  State<DetailGuru> createState() => _DetailGuruState();
}

class _DetailGuruState extends State<DetailGuru> {

  String NamaKelas = "";
  String NamaMapel = "";
  List<Map<String,dynamic>> data = [

  ];

  Future<List<dynamic>> getAbsenSiswa() async {
    final response = await http.post(
      Uri.parse("http://10.0.2.2/crm/getabsensi(siswa).php"),
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
    

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Detail Kelas")),
      body: 
      // Container(
      //       padding:  EdgeInsets.all(10),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Text(NamaKelas),
      //           Text(NamaMapel),
      //           Text("Daftar Siswa"),
      //           Divider(),
                FutureBuilder<List>(
                  future: getAbsenSiswa(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const SizedBox.shrink();
                    } else {
                    if (snapshot.hasData) {
                      return ListAbsen(list: snapshot.data!);
                    } else {
                      return const Center(child:  CircularProgressIndicator(),);
                    }
                    }
                  },
                )
              //]
            );
          //),
          
        
      //);
    
  }
  
  

}

class ListAbsen extends StatelessWidget {
  //const ItemList({super.key});
  final List<dynamic> list;
  const ListAbsen({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    if (list != null) {
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Card(
                  child: ListTile(
                    trailing: Text('Absensi :\t' + list[index]['absensi']),
                    title: Text(list[index]['nama'],),
              ));
        },
      );
    } else {
      return Text(" No Data");
    }
  }
}