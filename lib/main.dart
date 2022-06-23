// ignore_for_file: avoid_print, prefer_const_constructors, prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, avoid_unnecessary_containers, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:ihelpu_app/DriverScreen/signindriver.dart';
import 'package:ihelpu_app/signin.dart';
import 'package:ihelpu_app/signuppage.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainmenu.dart';
import 'DriverScreen/homepagedriver.dart';
import 'dart:convert';
import 'ipcon.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}//รันแอป

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String username = "";
  String usertype = "";
  Future getUserid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString('user_username') != null) {
      username = preferences.getString('user_username')!;
      usertype = "1";
      print(username);
      print(usertype);
    } else if (preferences.getString('officer_username') != null) {
      username = preferences.getString('officer_username')!;
      usertype = "2";
      print(username);
      print(usertype);
    } else {
      print(username);
    }
  }//ต้องการแสดงชื่อไอดีขึ้นมา โดยจะทำการ if else ว่าค่านั้นแสดงออกมาได้ไหมและจะมาแสดงค่าในส่วนของ output ให้ดู

  Future<List> getData() async {
    final response = await http.get(Uri.parse(
        ("http://${ipcon}/ihelpu/getuserid.php?user_id=${username}")));
    return json.decode(response.body);
  }//ดึงค่าจากตัวดาต้าเบส

  @override
  void initState() {
    getUserid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? Body(
                list: snapshot.data!,
                username: username,
                usertype: usertype, //แสดงข้อมูลจากคลาส body
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}

class Body extends StatelessWidget {
  final List list;
  final username;
  final usertype;
  Body({required this.list, this.username, this.usertype});
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: username == ""
          ? MyHomePage()
          : usertype == "1"
              ? MainMenuPage()
              : HomepageDriver(),
      duration: 5000,
      imageSize: 200,
      imageSrc: "assets/lodo.png",
      text: "iHelpU",
      textStyle: TextStyle(fontSize: 60.0, color: Colors.white),
      backgroundColor: Colors.orange[600],
    );
  }
}//หน้าแสดงภาพโหลดเข้าแอพ

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: size.shortestSide - 150,
                color: Colors.orange[600],
                // alignment: FractionalOffset.center,
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
                child: Column(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Text(
                          'ยินดีต้อนรับ',
                          style: TextStyle(fontSize: 45, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Text(
                          'iHelpU',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 80),
              SizedBox(
                width: 250,
                height: 60,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Colors.orange[600],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return SignInPage();//ส่งไปที่หน้าล็อคอินผู้ใช้
                      }),
                    );
                  },
                  child: Text(
                    'ล็อคอินผู้ใช้งาน',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: 250,
                height: 60,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Colors.orange[600],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return SignInpageDriver();//ส่งไปหน้าล็อคอินเจ้าหน้าที่
                      }),
                    );
                  },
                  child: Text(
                    'ล็อคอินผู้ให้ความช่วยเหลือ',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Divider(
                  thickness: 2,
                  color: Colors.orange[600],
                  height: 15,
                ),
              ),
              Text('ยังไม่มีบัชชีใช่ไหม ?',
                  style: TextStyle(fontSize: 16, color: Colors.black)),
              SizedBox(height: 15),
              SizedBox(
                width: 250,
                height: 60,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Colors.orange[600],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return SignUpPages();//ส่งไปหน้าสมัครสมาชิก
                      }),
                    );
                  },
                  child: Text(
                    'สมัครสมาชิก',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}//หน้าเริ่มต้น
