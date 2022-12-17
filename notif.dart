import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Notice extends StatefulWidget {
  const Notice({Key? key}) : super(key: key);

  @override
  State<Notice> createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  TextEditingController search = new TextEditingController();
  TextEditingController nama = new TextEditingController();
  TextEditingController idRole = new TextEditingController();
  
  Future<List<dynamic>> getDataNotif() async {
    final response = await http.post(
      Uri.parse("http://10.0.2.2/crm/getdata(notif).php"),
      body: {
        "nama": nama.text,
      }
      );
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    String user = ModalRoute.of(context)!.settings.arguments.toString();
    nama.text = user;
     return //Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Text('Selamat datang ' + user + '! '),
    //       RoundedSearchField(hintText: 'Cari Kelas', icon: Icons.search, onChanged: (value){}, controller: search),
          FutureBuilder<List>(
        future: getDataNotif(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const SizedBox.shrink();
          } else {
            if (snapshot.hasData) {
              return ItemList(list: snapshot.data!);
            } else {
              return const Center(child:  CircularProgressIndicator(),);
            }
          }
        },
      );
      //   ],
      // );
  }
}

class ItemList extends StatelessWidget {
  //const ItemList({super.key});
  final List<dynamic> list;
  const ItemList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    if (list != null) {
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/detailnotif',
                  arguments: list[index]),
              child: Card(
                  child: ListTile(
                title: Text(
                  list[index]['judul'],
                ),
                subtitle: Text(list[index]['konten']),
                //trailing: Text("stok\t:" + list[index]['stock']),
              )));
        },
      );
    } else {
      return Text(" No Data");
    }
  }
}