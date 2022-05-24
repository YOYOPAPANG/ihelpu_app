// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:ihelpu_app/DriverScreen/editpassdriver.dart';
import 'package:ihelpu_app/DriverScreen/editprofiledriver.dart';
import 'package:ihelpu_app/ipcon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDriverPage extends StatefulWidget {
  final list;
  ProfileDriverPage({this.list});

  @override
  _ProfileDriverPageState createState() => _ProfileDriverPageState();
}

class _ProfileDriverPageState extends State<ProfileDriverPage> {
  String officer_username = "";
  String officer_id = "";
  String password = "";
  String officer_images = "";

  TextEditingController organi_name = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController officer_tel = TextEditingController();
  TextEditingController email = TextEditingController();

  File? _images;

  Future getUserid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      officer_username = preferences.getString('officer_username')!;
    });
  }

  Future<List> getofficerFullname() async {
    final response = await http.get(Uri.parse(
        "http://$ipcon/ihelpu/driverscreen/getofficerid.php?officer_id=${officer_username}"));
    setState(() {});
    return json.decode(response.body);
  }

  @override
  void initState() {
    getUserid();
    jojo();
    print(widget.list);
    super.initState();
  }

  List a = List.empty();
  String id = "";
  void jojo() async {
    fullname = TextEditingController(text: widget.list['officer_fullname']);
    officer_tel = TextEditingController(text: widget.list['officer_tel']);
    organi_name = TextEditingController(text: widget.list['organi_name']);
    email = TextEditingController(text: widget.list['officer_email']);
    officer_id = widget.list['officer_id'];
    password = widget.list['officer_password'];
    officer_images = widget.list['officer_images'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Account"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(CupertinoIcons.arrow_turn_down_left),
            onPressed: () {
              return Navigator.pop(context);
            },
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.greenAccent[400],
        ),
        body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 250.0,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                        ),
                        _images == null
                            ? Container(
                                width: 170,
                                height: 170,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 4, color: Colors.white),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.1))
                                  ],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'http://$ipcon/ihelpu/upload/${officer_images}'),
                                  ),
                                ),
                              )
                            : Container(
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: FileImage(_images!),
                                ),
                                width: 170,
                                height: 170,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "ข้อมูลส่วนตัว",
                                style: TextStyle(fontSize: 24),
                              ),
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'ชื่อหน่วยงาน',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextField(
                                      readOnly: true,
                                      controller: organi_name,
                                      decoration: const InputDecoration(
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'ชื่อ - นามสกุล',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextField(
                                      readOnly: true,
                                      controller: fullname,
                                      decoration: const InputDecoration(
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'เบอร์โทรศัพท์',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: TextField(
                                        readOnly: true,
                                        controller: officer_tel,
                                        decoration: const InputDecoration(
                                          filled: true,
                                        ),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'อีเมล',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextField(
                                      readOnly: true,
                                      controller: email,
                                      decoration: const InputDecoration(
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 5, right: 5),
                                height: 50,
                                width: 150,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  color: Colors.green, // background
                                  textColor: Colors.white, // foreground
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return EditProfileDriver(
                                        organi_name: organi_name.text,
                                        fullname: fullname.text,
                                        email: email.text,
                                        officer_tel: officer_tel.text,
                                        officer_id: officer_id,
                                        officer_images: officer_images,
                                      );
                                    }));
                                  },
                                  child: Text('แก้ไขข้อมูล'),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 5, left: 5),
                                height: 50,
                                width: 150,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  color: Colors.yellow[800], // background
                                  textColor: Colors.white, // foreground
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return EditPassDriverPage(
                                        officer_id: officer_id,
                                      );
                                    }));
                                  },
                                  child: Text('แก้ไขรหัสผ่าน'),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
