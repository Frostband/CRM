import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/rounded_input_field.dart';
import 'components/rounded_password_field.dart';
import 'constant.dart';
import 'package:http/http.dart' as http;

import 'dashboard.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'School Center App',
      theme: ThemeData(
        scaffoldBackgroundColor: kPrimaryColor,
        primarySwatch: kPrimaryColor,
      ),
      initialRoute: '/main',
      routes: {
        '/main' :(context) => Home(),
        //'/details' :(context) => Detail(),
        //'/add' :(context) => Add(),
        '/dashboard':(context) => Dashboard(),
      },      
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  //bool userFound = false;
  //String valid = '';

  /*Future<List<dynamic>> getData() async {
    final response =
        await http.get(Uri.parse("http://10.0.2.2/crm/login2.php"));
    return json.decode(json.encode(response.body));
  }*/

  login() async {
    
    var response = await http.post(
      Uri.parse('http://10.0.2.2/crm/login.php'),
      body: {

        "username": user.text,
        "password": pass.text,
      },
    );
    
    var responseLogin = json.decode(response.body); 
    
    if(responseLogin["success"]==true) {
      //userFound = true;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login berhasil')));
      Navigator.pushReplacementNamed(context, '/dashboard', arguments: user.text);
      //Navigator.pushNamed(context, '/details', arguments: user.text);
      //User userInfo = User.fromJson(responseLogin["userData"]);
      
    } else {
      //userFound = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login gagal')));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /*FutureBuilder<List>(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Login gagal ada error');
              } else {
              if (snapshot.hasData) {
                UserList(list: snapshot.data!);
                return Text('');
                //return UserList(list: snapshot.data!);
              } else {
                return const Center(child:  CircularProgressIndicator(),);
              }
              }
            },
          ),*/
          Text("Central Report App", style: TextStyle(fontSize: 24, color: Colors.white),),
          Text("Login Untuk Melanjutkan", style: TextStyle(fontSize: 12, color: Colors.white),),
          SvgPicture.asset(
            "assets/icons/sma.svg",
            height: size.height * 0.15,
            color: Colors.blue,
          ),
          /*Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: user,
              decoration: InputDecoration(
                  labelText: "username",
                  hintText: "inputkan username",
                  icon: Icon(Icons.person)
                  ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: pass,
              decoration: InputDecoration(
                  labelText: "password",
                  hintText: "inputkan password",
                  icon: Icon(Icons.lock)
                  ),
            ),
          ),*/
          RoundedInputField(
            controller: user,
            hintText: "Username",
            onChanged: (value){}, 
            icon: Icons.person,
          ),
            RoundedPasswordField(
              controller: pass,
              onChanged: (value) {},
            ),
            ElevatedButton(onPressed: (() {
              login();
              // if(userFound == true) {
                
              // } else {
                
              // };
            }), child: Text('Login')),      
        ],
      ),
    ),
    );
  }
}

class User
{
  int id;
  String username;
  String password;

  User(
    this.id,
    this.username,
    this.password
  );

  factory User.fromJson(Map<String, dynamic> json) => User(
    int.parse(json["id"]),
    json["username"],
    json["password"],
  );

  Map<String, dynamic> toJson() => {
    'id': id.toString(),
    'username': username,
    'password': password,
  };
}