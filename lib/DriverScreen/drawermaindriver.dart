// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihelpu_app/DriverScreen/profiledriver.dart';
import 'package:ihelpu_app/ipcon.dart';
import 'package:ihelpu_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class DrawerMaindriver extends StatefulWidget {
  @override
  _DrawerMaindriverState createState() => _DrawerMaindriverState();
}

class _DrawerMaindriverState extends State<DrawerMaindriver> {
  String officer_username = "";

  Future getUserid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      officer_username = preferences.getString('officer_username')!;
    });
  }

  Future<List> getofficerFullname() async {
    final response = await http.get(Uri.parse(
        "http://$ipcon/ihelpu/driverscreen/getofficerid.php?officer_id=${officer_username}"));
    return json.decode(response.body);
  }

  @override
  void initState() {
    getUserid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: getofficerFullname(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
        }
        if (snapshot.hasData) {
          return DrawerMaindriverMenu(
            list: snapshot.data!,
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class DrawerMaindriverMenu extends StatelessWidget {
  final list;
  File? _images;
  DrawerMaindriverMenu({this.list});

  void logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: [
            buildHeader(
                name: '      IhelpU',
                onTapped: () {
                  Navigator.pop(context);
                }),
            SizedBox(height: 20),
            Container(
              child: Column(
                children: [
                  _images == null
                      ? Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(width: 4, color: Colors.white),
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
                                  'http://$ipcon/ihelpu/upload/${list[0]['officer_images']}'),
                            ),
                          ),
                        )
                      : Container(
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: FileImage(_images!),
                          ),
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    list[0]['officer_fullname'],
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  buildMenuItem(
                    text: "หน้าแรก",
                    iconLead: Icons.home,
                    iconTrail: CupertinoIcons.chevron_forward,
                    onClicked: () {
                      Navigator.of(context).pop();
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (BuildContext context) {
                      //   return MainMenuPage();
                      // }));
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  buildMenuItem(
                    text: "บัญชี",
                    iconLead: CupertinoIcons.person_alt,
                    iconTrail: CupertinoIcons.chevron_forward,
                    onClicked: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return ProfileDriverPage(
                          list: list[0],
                        );
                      }));
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  buildMenuItem(
                    text: "ออกจากระบบ",
                    iconLead: CupertinoIcons.square_arrow_right,
                    iconTrail: CupertinoIcons.chevron_forward,
                    onClicked: () {
                      logout();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return MyApp();
                      }));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildHeader({required String name, required VoidCallback onTapped}) =>
    InkWell(
      child: Container(
        height: 57,
        color: Colors.greenAccent[400],
        child: Row(
          children: [
            SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 65.0, right: 65.0),
                  child: Container(
                    child: Text(
                      name,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: onTapped,
                icon: Icon(CupertinoIcons.multiply),
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );

Widget buildMenuItem({
  required String text,
  required IconData iconLead,
  required IconData iconTrail,
  VoidCallback? onClicked,
}) {
  return ListTile(
    leading: CircleAvatar(
      radius: 24,
      backgroundColor: Colors.greenAccent,
      child: Icon(iconLead, color: Colors.white),
    ),
    trailing: Icon(iconTrail),
    title: Text(text),
    onTap: onClicked,
  );
}
