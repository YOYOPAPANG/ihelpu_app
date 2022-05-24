// ignore_for_file: prefer_const_constructors, avoid_print, non_constant_identifier_names, unnecessary_brace_in_string_interps, must_call_super, use_key_in_widget_constructors, prefer_final_fields

import 'package:http/http.dart' as http;
import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ihelpu_app/drawermain.dart';
import 'package:ihelpu_app/emergencycall.dart';
import 'package:ihelpu_app/ipcon.dart';
import 'package:ihelpu_app/searchhospital.dart';
import 'package:ihelpu_app/waitingofficer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenuPage extends StatefulWidget {
  static const routeName = '/mainmenu';

  @override
  _MainMenuPageState createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();

  String userid = '';

  String latlonglocal = '';

  void requestEmergency(String request_type, DateTime request_time,
      String request_locat, int request_status) async {
    String time = DateFormat('HH:mm:ss').format(request_time);
    print(time);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString('user_username');
    userid = preferences.getString('user_username')!;
    var url = Uri.parse(
        "http://$ipcon/ihelpu/requestEmer.php?request_type=${request_type}&request_time=${time}&user_lat=${latitude}&user_lng=${longitude}&request_status=${request_status}&user_id=${userid}");
    http.get(url);
  }

  @override
  void initState() {
    getCurrentLocation((lat, long) {
      setState(() {
        latitude = lat;
        longitude = long;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      drawer: DrawerMain(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'ihelpU',
            style: TextStyle(color: Colors.white, fontSize: 38),
          ),
          centerTitle: true,
          backgroundColor: Colors.orange,
          leading: IconButton(
            padding: EdgeInsets.only(top: 8, left: 15),
            onPressed: () {
              return _scaffoldKey.currentState!.openDrawer();
            },
            icon: Icon(Icons.menu, size: 36),
          ),
        ),
      ),
      body: ListView(
        children: [
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        print('SOS');
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Center(
                                child: Container(
                                    height: 300,
                                    width: 300,
                                    child: Material(
                                      child: Column(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(top: 20),
                                              child: Text('เลือกประเภท',
                                                  style: GoogleFonts.prompt(
                                                      fontSize: 22,
                                                      color: Colors.black))),
                                          Padding(
                                            padding: EdgeInsets.only(top: 20),
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    padding: EdgeInsets.only(
                                                        left: 25, right: 25),
                                                    primary: Colors.red),
                                                onPressed: () {
                                                  requestEmergency(
                                                      'ฉุกเฉิน',
                                                      DateTime.now(),
                                                      latlonglocal,
                                                      2);
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(builder:
                                                          (BuildContext
                                                              context) {
                                                    return WaitingPage(
                                                        request_type: 'ฉุกเฉิน',
                                                        request_locat:
                                                            latlonglocal);
                                                  }));
                                                },
                                                child: Container(
                                                    width: 60,
                                                    child: Center(
                                                        child: Text('ฉุกเฉิน',
                                                            style: GoogleFonts
                                                                .prompt(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .white))))),
                                          ),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.only(
                                                      left: 25, right: 25),
                                                  primary: Colors.yellow[700]),
                                              onPressed: () {
                                                requestEmergency(
                                                    'อุบัติเหตุ',
                                                    DateTime.now(),
                                                    latlonglocal,
                                                    2);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(builder:
                                                        (BuildContext context) {
                                                  return WaitingPage(
                                                      request_type:
                                                          'อุบัติเหตุ',
                                                      request_locat:
                                                          latlonglocal);
                                                }));
                                              },
                                              child: Container(
                                                  width: 60,
                                                  child: Center(
                                                      child: Text('อุบัติเหตุ',
                                                          style: GoogleFonts
                                                              .prompt(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .white))))),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.only(
                                                      left: 25, right: 25),
                                                  primary: Colors.grey),
                                              onPressed: () {
                                                requestEmergency(
                                                    'อื่นๆ',
                                                    DateTime.now(),
                                                    latlonglocal,
                                                    2);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(builder:
                                                        (BuildContext context) {
                                                  return WaitingPage(
                                                      request_type: 'อื่นๆ',
                                                      request_locat:
                                                          latlonglocal);
                                                }));
                                              },
                                              child: Container(
                                                  width: 60,
                                                  child: Center(
                                                      child: Text('อื่นๆ',
                                                          style: GoogleFonts
                                                              .prompt(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .white))))),
                                          Padding(
                                            padding: EdgeInsets.only(top: 25),
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    padding: EdgeInsets.only(
                                                        left: 25, right: 25),
                                                    primary: Colors.red),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                    width: 60,
                                                    child: Center(
                                                        child: Text('Cancel',
                                                            style: GoogleFonts
                                                                .prompt(
                                                                    fontSize:
                                                                        17,
                                                                    color: Colors
                                                                        .white))))),
                                          ),
                                        ],
                                      ),
                                    )),
                              );
                            });
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          'SOS',
                          style: TextStyle(fontSize: 56, color: Colors.white),
                        ),
                        Text(
                          'กดเรียกขอความช่วยเหลือ',
                          style: GoogleFonts.prompt(
                              fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(75),
                      primary: Colors.redAccent[400],
                      onPrimary: Colors.orangeAccent[600],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'รอสักครู่!',
                    style: GoogleFonts.prompt(
                        fontSize: 20, color: Colors.redAccent[400]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    'หลังจากกดปุ่ม SOS คุณจะได้รับความ \n ช่วยเหลือภายใน 8 - 10 วินาที',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.prompt(
                        fontSize: 16, color: Colors.grey[400]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Table(
                    border:
                        TableBorder.all(width: 3, color: Colors.grey.shade400),
                    columnWidths: const <int, TableColumnWidth>{
                      0: IntrinsicColumnWidth(),
                      1: FlexColumnWidth(2),
                      2: FixedColumnWidth(2),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      TableRow(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 45),
                                height: 120,
                                width: size.shortestSide - 225,
                                alignment: Alignment.center,
                                child: Container(
                                  height: 55,
                                  width: 55,
                                  child: AvatarView(
                                    borderWidth: 3,
                                    radius: 65,
                                    borderColor: Colors.red,
                                    avatarType: AvatarType.RECTANGLE,
                                    backgroundColor: Colors.transparent,
                                    imagePath: "assets/emergencycall.png",
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                        return EmergencyCallPage();
                                      }));
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 30),
                                child: Text(
                                  'เบอร์โทรฉุกเฉิน',
                                  style: GoogleFonts.prompt(
                                      fontSize: 16, color: Colors.grey[700]),
                                ),
                              ),
                            ],
                          ),
                          TableCell(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 35),
                                  alignment: Alignment.center,
                                  height: 120,
                                  child: Container(
                                    padding: EdgeInsets.only(top: 15),
                                    height: 70,
                                    width: 60,
                                    child: AvatarView(
                                      radius: 45,
                                      borderWidth: 3,
                                      borderColor: Colors.red,
                                      backgroundColor: Colors.transparent,
                                      avatarType: AvatarType.CIRCLE,
                                      imagePath: "assets/hospital.png",
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                          return SearchHospitalPage(
                                              provName: '');
                                        }));
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 5, bottom: 35),
                                  child: Text(
                                    'ค้นหาโรงพยาบาล',
                                    style: GoogleFonts.prompt(
                                        fontSize: 16, color: Colors.grey[700]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
