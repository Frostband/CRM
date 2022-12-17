import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uas/agenda.dart';
import 'package:uas/notif.dart';
import 'package:http/http.dart' as http;


class DashboardGuru extends StatelessWidget {
  //const ScrollTab({Key? key}) : super(key: key);

  List<Tab> tabs = [
    Tab(child: Text('Kelas ku'),),
    Tab(child: Text('Agenda'),),
    Tab(child: Text('Notice'),),
  ];

  List<Widget> tabsContent = [
    Container(color: Colors.white, child: UserDashGuru(),),
    Container(color: Colors.white, child: Agenda(),),
    Container(color: Colors.white, child: Notice(),),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Central App Management'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30), 
            child: TabBar(
              indicatorColor: Colors.white,
              isScrollable: true,
              tabs: tabs,
            ) )) ,
        body: TabBarView(
          children: tabsContent,
        )));
  }
}

class UserDashGuru extends StatefulWidget {
  const UserDashGuru({Key? key}) : super(key: key);

  @override
  State<UserDashGuru> createState() => _UserDashGuruState();
}

class _UserDashGuruState extends State<UserDashGuru> {
  TextEditingController search = new TextEditingController();
  TextEditingController nama = new TextEditingController();
  TextEditingController idRole = new TextEditingController();
  
  Future<List<dynamic>> getDataGuru() async {
    final response = await http.post(
      Uri.parse("http://10.0.2.2/crm/getuser(guru)data.php"),
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
        future: getDataGuru(),
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
              onTap: () => Navigator.pushNamed(context, '/detailguru',
                  arguments: list[index]),
              child: Card(
                  child: ListTile(
                title: Text(
                  list[index]['nama_kelas'],
                ),
                subtitle: Text(list[index]['nama_mapel']),
                //trailing: Text("stok\t:" + list[index]['stock']),
              )));
        },
      );
    } else {
      return Text(" No Data");
    }
  }
}
