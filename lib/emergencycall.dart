// ignore_for_file: prefer_const_constructors, avoid_print, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:ihelpu_app/ipcon.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class EmergencyCallPage extends StatefulWidget {
  @override
  _EmergencyCallPageState createState() => _EmergencyCallPageState();
}

class _EmergencyCallPageState extends State<EmergencyCallPage> {
  String getSearch = '';

  String searchNameEmer1 = '';

  TextEditingController SearchNameEmer = TextEditingController();

  Future<List> getEmerCall2() async {
    final response = await http.get(Uri.parse(
        "http://$ipcon/ihelpu/emergencycall2.php?SearchName=${searchNameEmer1}"));
    setState(() {});
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            padding: EdgeInsets.only(right: 0),
            icon:
                Icon(CupertinoIcons.arrow_left, size: 23, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'สายด่วนสำหรับเหตุด่วนเหตุร้าย',
            style: GoogleFonts.prompt(fontSize: 18, color: Colors.black),
          ),
          actions: [
            IconButton(
              padding: EdgeInsets.only(right: 32),
              icon: Icon(
                Icons.home_outlined,
                size: 34,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    height: 65,
                    width: double.infinity,
                    color: Colors.orange[700],
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Material(
                        borderRadius: BorderRadius.circular(40),
                        child: TextField(
                          controller: SearchNameEmer,
                          onChanged: (v) {
                            setState() {
                              getSearch = v;
                              print(getSearch);
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'ค้นหาสายฉุกเฉิน',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search_rounded),
                              color: Colors.black,
                              onPressed: () {
                                setState(() {
                                  searchNameEmer1 = SearchNameEmer.text;
                                });
                              },
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 8.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                child: FutureBuilder<List>(
                  future: getEmerCall2(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                    }
                    if (snapshot.hasData) {
                      return EmercallData(listEmer: snapshot.data!);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmercallData extends StatefulWidget {
  final List listEmer;
  EmercallData({required this.listEmer});

  @override
  _EmercallDataState createState() => _EmercallDataState();
}

class _EmercallDataState extends State<EmercallData> {
  @override
  Widget build(BuildContext context) {
    return EmergencyCallData(listEmer: widget.listEmer);
  }
}

class EmergencyCallData extends StatelessWidget {
  final List listEmer;
  EmergencyCallData({required this.listEmer});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listEmer == null ? 0 : listEmer.length,
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () => _onAlertButtonsPressed(context,
                listEmer[i]['emercall_name'], listEmer[i]['emercall_tel']),
            child: Card(
              child: ListTile(
                title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Text(
                            listEmer[i]['emercall_name'],
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            listEmer[i]['emercall_tel'],
                            style: TextStyle(
                                fontSize: 18, color: Colors.redAccent[700]),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // trailing:
                //     const Icon(Icons.local_phone,
                //     color: Colors.red, size: 32),
              ),
            ),
          ),
        );
      },
    );
  }

  _onAlertButtonsPressed(context, String Emername, String EmerTel) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "คุณแน่ใจที่จะโทรหาหรือไม่",
      desc: Emername + "\n" + EmerTel,
      buttons: [
        DialogButton(
          child: Text(
            "โทร",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          onPressed: () {
            print(EmerTel);
            _callNumber(EmerTel);
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "ยกเลิก",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.red,
        ),
      ],
    ).show();
  }
}

_callNumber(String phoneNumber) async {
  String number = phoneNumber;
  await FlutterPhoneDirectCaller.callNumber(number);
}
