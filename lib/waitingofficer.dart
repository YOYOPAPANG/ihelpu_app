// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ihelpu_app/checkaccept.dart';
import 'package:ihelpu_app/drawermain.dart';
import 'package:ihelpu_app/ipcon.dart';
import 'package:ihelpu_app/mainmenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

Timer? timer;

void cancelWaiting(
    {DateTime? request_time,
    String? request_locat,
    String? request_type}) async {
  print("cancelWaiting");
  String _username = "";
  String time = DateFormat('HH:mm:ss').format(request_time!);
  SharedPreferences preferences = await SharedPreferences.getInstance();
  _username = preferences.getString('user_username')!;
  var url = Uri.parse("http://$ipcon/ihelpu/cancelwaitingAccept.php");
  var response = await http.post(url, body: {
    "request_time": time.toString(),
    "request_status": "0",
    "user_id": _username,
    "request_type": request_type,
    "request_locat": request_locat.toString()
  });
}

class WaitingPage extends StatefulWidget {
  final String request_type;
  final String request_locat;
  const WaitingPage(
      {Key? key, required this.request_type, required this.request_locat})
      : super(key: key);

  @override
  _WaitingPageState createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final spinkit =
      SpinKitThreeInOut(itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
        decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color: index.isEven ? Colors.orange : Colors.yellowAccent,
    ));
  });

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        Duration(seconds: 10),
        (Timer t) => CheckAccept(
                request_locat: widget.request_locat,
                request_type: widget.request_type)
            .Checkaccp(context));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            drawer: DrawerMain(),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(65.0),
              child: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  'รอเจ้าหน้าที่',
                  style: TextStyle(color: Colors.white, fontSize: 32),
                ),
                centerTitle: true,
                backgroundColor: Colors.orangeAccent[600],
                leading: IconButton(
                  padding: EdgeInsets.only(top: 8, left: 15),
                  onPressed: () {
                    return _scaffoldKey.currentState!.openDrawer();
                  },
                  icon: Icon(Icons.menu, size: 36),
                ),
              ),
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Container(
                      child: Text("กำลังรอเจ้าหน้าที่ตอบรับ",
                          style: GoogleFonts.prompt(
                              fontSize: 20, color: Colors.black))),
                  SizedBox(height: 15),
                  Container(
                    color: Colors.white,
                    height: 100,
                    width: 150,
                    child: spinkit,
                  ),
                  Container(
                    height: 200,
                    // color: Colors.grey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("สามารถยกเลิกได้",
                            style: GoogleFonts.prompt(
                                fontSize: 14, color: Colors.black)),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.greenAccent[400]),
                              onPressed: () {
                                setState(() {
                                  timer?.cancel();
                                  cancelWaiting(
                                      request_time: DateTime.now(),
                                      request_type: widget.request_type,
                                      request_locat: widget.request_locat);
                                });
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return MainMenuPage();
                                }));
                              },
                              child: Text('ยกเลิกการขอความช่วยเหลือ',
                                  style: GoogleFonts.prompt(
                                      fontSize: 16, color: Colors.white))),
                        )
                      ],
                    ),
                  )
                ]))));
  }
}
