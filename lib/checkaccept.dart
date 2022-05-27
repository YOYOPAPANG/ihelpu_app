// ignore_for_file: non_constant_identifier_names, avoid_print, unnecessary_brace_in_string_interps, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, unused_import

import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ihelpu_app/ipcon.dart';
import 'package:ihelpu_app/mainmenu.dart';
import 'package:ihelpu_app/searchhospital.dart';
import 'package:ihelpu_app/waitingofficer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckAccept {
  final String request_type;
  final String request_locat;
  CheckAccept({required this.request_type, required this.request_locat});
  void Checkaccp(BuildContext context) async {
    print("check");
    String _username = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _username = preferences.getString(
      'user_username',
    )!;
    print(_username);
    final response = await http.get(
        Uri.parse("http://$ipcon/ihelpu/checkAccept.php?user_id=${_username}"));
    var data = json.decode(response.body);

    print(data[0]);
    if (data[0]["request_status"] == "1") {
      timer?.cancel();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
        return Acceptofficer(
            request_locat: request_locat,
            request_type: request_type,
            officer_id: data[0]['officer_id']);
      }));
    } else {}
  }
}

class Acceptofficer extends StatefulWidget {
  final String request_type;
  final String request_locat;
  final String officer_id;
  Acceptofficer(
      {required this.request_type,
      required this.request_locat,
      required this.officer_id});

  @override
  _AcceptofficerState createState() => _AcceptofficerState();
}

class _AcceptofficerState extends State<Acceptofficer> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool Loading = true;

  List showoffi = [''];

  Future<List> showofficer() async {
    final response = await http.get(Uri.parse(
        "http://$ipcon/ihelpu/showofficer.php?officer_id=${widget.officer_id}"));
    var datajson = json.decode(response.body);
    setState(() {
      Loading = false;
      showoffi = datajson;
    });
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            // key: _scaffoldKey,
            // drawer: DrawerMain(),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(65.0),
              child: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  'เจ้าหน้าที่ตอบรับ',
                  style: TextStyle(color: Colors.white, fontSize: 32),
                ),
                centerTitle: true,
                backgroundColor: Colors.orange,
              ),
            ),
            body: Container(
                child: FutureBuilder(
                    future: showofficer(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                      }
                      if (snapshot.hasData) {
                        return Showofficer(
                            request_type: widget.request_type,
                            request_locat: widget.request_locat,
                            list: snapshot.data,
                            officer_id: widget.officer_id);
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }))));
  }
}

class Showofficer extends StatefulWidget {
  final list;
  final String request_type;
  final String request_locat;
  final officer_id;
  Showofficer(
      {this.list,
      required this.request_type,
      required this.request_locat,
      required this.officer_id});

  @override
  _ShowofficerState createState() => _ShowofficerState();
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
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing:
                    new Icon(Icons.local_phone, color: Colors.red, size: 32),
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
            "Call",
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
            "Cancel",
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

class _ShowofficerState extends State<Showofficer> {
  List addDataloca = [];
  List<Marker> locat = [];

  Future<List> addDatalocat() async {
    final response = await http.get(Uri.parse(
        "http://$ipcon/ihelpu/driverscreen/showrequestofficerlocat.php?officer_id=${widget.officer_id}"));
    var addDatalocat = json.decode(response.body);
    setState(() {
      addDataloca = addDatalocat;
    });

    String addData1 = addDataloca[0]['officer_locat'];
    List addData2 = addData1.split(',');

    return addData2;
  }

  Set<Marker> myMarker() {
    return <Marker>{
      Marker(
          markerId: MarkerId('my location'),
          position: LatLng(double.parse(latitude), double.parse(longitude)),
          infoWindow: InfoWindow(title: 'ตำแหน่งของคุณ'))
    };
  }

  Timer? timercheck;
  @override
  void initState() {
    timercheck = Timer.periodic(
        Duration(seconds: 10), (Timer t) => CheckaccpEnd(context));
    super.initState();
  }

  void CheckaccpEnd(BuildContext context) async {
    String _username = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _username = preferences.getString(
      'user_username',
    )!;

    final response = await http.get(
        Uri.parse("http://$ipcon/ihelpu/checkAccept.php?user_id=${_username}"));
    var data = json.decode(response.body);

    if (data[0]["request_status"] == "0") {
      timercheck?.cancel();
      print("Pass");
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return MainMenuPage();
      }), (route) => false);
    } else {}
  }

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      SizedBox(height: 20),
      Container(
          child: Text("เจ้าหน้าที่ตอบรับเรียบร้อยแล้ว",
              style: GoogleFonts.prompt(fontSize: 20, color: Colors.black))),
      SizedBox(height: 30),
      Container(
        // color: Colors.grey,
        height: 500,
        width: 350,
        child: ListView.builder(
            itemCount: widget.list == null ? 0 : widget.list.length,
            itemBuilder: (context, i) {
              return Column(
                children: [
                  Text('ข้อมูลของเจ้าหน้าที่'),
                  SizedBox(height: 20),
                  Text('ชื่อเจ้าหน้าที่ : ' +
                      widget.list[i]['officer_fullname']),
                  Text('หน่วยงาน : ' + widget.list[i]['organi_name']),
                  Text('เบอร์โทรศัพท์ : ' + widget.list[i]['officer_tel']),
                  SizedBox(height: 20),
                  Container(
                    height: 350,
                    child: FutureBuilder<List>(
                        future: addDatalocat(),
                        builder: (context, data) {
                          return data.hasData
                              ? GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(
                                        double.parse(data.data![0]),
                                        double.parse(data.data![
                                            1])), //กำหนดพิกัดเริ่มต้นบนแผนที่
                                    zoom: 18, //กำหนดระยะการซูม กำหนดได้ 0-20
                                  ),
                                  mapType: MapType.normal,
                                  myLocationEnabled: true,
                                  markers: {
                                    Marker(
                                        markerId: MarkerId('Test02'),
                                        position: LatLng(
                                            double.parse(data.data![0]),
                                            double.parse(data.data![1])),
                                        infoWindow: InfoWindow(
                                            title: 'ชื่อ : ' +
                                                addDataloca[0]
                                                    ['officer_fullname'],
                                            snippet: 'ชื่อหน่วยงาน : ' +
                                                addDataloca[0]['organi_name']))
                                  },
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    _controller.complete(controller);
                                  },
                                )
                              : Center(child: CircularProgressIndicator());
                        }),
                  )
                ],
              );
            }),
      ),
      Container(
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.orange),
                  onPressed: () {
                    _callNumber(widget.list[0]['officer_tel']);
                  },
                  child: Text('โทรหาเจ้าหน้าที่',
                      style: GoogleFonts.prompt(
                          fontSize: 16, color: Colors.white))),
            )
          ],
        ),
      )
    ]));
  }

  _callNumber(String phoneNumber) async {
    String number = phoneNumber;
    await FlutterPhoneDirectCaller.callNumber(number);
  }
}
