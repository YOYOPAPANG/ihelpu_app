// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihelpu_app/ipcon.dart';
import 'package:ihelpu_app/main.dart';
import 'package:ihelpu_app/profile2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class DrawerMain extends StatefulWidget {
  @override
  _DrawerMainState createState() => _DrawerMainState();
}

class _DrawerMainState extends State<DrawerMain> {
  String username = "";

  Future getUserid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString('user_username')!;
    });
  }

  Future<List> getFullname() async {
    final response = await http.get(
        Uri.parse("http://$ipcon/ihelpu/getuserid.php?user_id=${username}"));
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
      future: getFullname(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
        }
        if (snapshot.hasData) {
          return Drawermenu(
            list: snapshot.data!,
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class Drawermenu extends StatelessWidget {
  final list;
  File? _images;
  String? img;

  Drawermenu({this.list});

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
                  list[0]['user_images'] == ''
                      ? Container(
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                AssetImage('assets/images/profile.jpg'),
                          ),
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)),
                        )
                      : Container(
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
                                  'http://$ipcon/ihelpu/upload/${list[0]['user_images']}'),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    list[0]['user_fullname'],
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage2(
                                    list: list[0],
                                  )));
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
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
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
        color: Colors.orange[400],
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
      backgroundColor: Colors.orange[700],
      child: Icon(iconLead, color: Colors.white),
    ),
    trailing: Icon(iconTrail),
    title: Text(text),
    onTap: onClicked,
  );
}
