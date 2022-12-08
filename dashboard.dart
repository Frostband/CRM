import 'package:flutter/material.dart';

import 'components/rounded_search_field.dart';


class Dashboard extends StatelessWidget {
  //const ScrollTab({Key? key}) : super(key: key);

  List<Tab> tabs = [
    Tab(child: Text('Kelas ku'),),
    Tab(child: Text('Agenda'),),
    Tab(child: Text('Notice'),),
  ];

  List<Widget> tabsContent = [
    Container(color: Colors.white,
    child: UserDash(),),
    Container(color: Colors.white,),
    Container(color: Colors.white,),
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

class UserDash extends StatefulWidget {
  const UserDash({Key? key}) : super(key: key);

  @override
  State<UserDash> createState() => _UserDashState();
}

class _UserDashState extends State<UserDash> {
  TextEditingController search = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    String username = ModalRoute.of(context)!.settings.arguments.toString();
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Selamat datang ' + username + '! '),
          RoundedSearchField(hintText: 'Cari Kelas', icon: Icons.search, onChanged: (value){}, controller: search)
          
        ],
      );
  }
}