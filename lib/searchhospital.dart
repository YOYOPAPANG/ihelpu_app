// ignore_for_file: must_be_immutable, avoid_print, use_key_in_widget_constructors, non_constant_identifier_names, prefer_typing_uninitialized_variables, unnecessary_null_comparison, unnecessary_brace_in_string_interps, prefer_const_constructors, sized_box_for_whitespace, camel_case_types

import 'dart:convert';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ihelpu_app/drawergeography.dart';
import 'package:ihelpu_app/ipcon.dart';
import 'package:ihelpu_app/mainmenu.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class locationMe {
  String latitude;
  String longitude;

  locationMe({
    required this.latitude,
    required this.longitude,
  });
}

var locationMessage = '';
String latitude = '';
String longitude = '';

// function for getting the current location
// but before that you need to add this permission!
void getCurrentLocation(Function(String, String) Callbackfunc) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();//ใช้สำหรับระบุตำแหน่ง
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }//ฟังชั่นสำหรับการขออณุญาตเข้าถึงการระบุตำแหน่ง

  var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best);
  var lat = position.latitude;
  var long = position.longitude;

  // passing this to latitude and longitude strings //เก็บค่าเป็นสติงเพื่อง่ายต่อการนำไปใช้งาน
  latitude = "$lat";
  longitude = "$long";

  locationMessage = "Latitude: $lat and Longitude: $long";

  print(locationMessage);

  Callbackfunc(lat.toString(), long.toString());
}

class SearchHospitalPage extends StatefulWidget {
  String? provName = '';
  SearchHospitalPage({this.provName});
  @override
  _SearchHospitalPageState createState() => _SearchHospitalPageState();
}

class _SearchHospitalPageState extends State<SearchHospitalPage> {
  String getSearch = '';
  String getprovinId = '';
  TextEditingController SearchNamehospit = TextEditingController();

  int listlength = 0;
  List gethospit = List.empty();
  String getorderbyhospit = '';

  Future<List> gethospital() async {//แสดงโรงบาลที่อยู่ใกล้เราตามตำแหน่ง
    getCurrentLocation((lat, long) {
      setState(() {
        latitude = lat;
        longitude = long;
      });
    });
    print(widget.provName);
    print(getSearch);
    print(SearchNamehospit.text);
    var response;
    if (getSearch == '' || getSearch == null) {
      //if dont search
      if (getorderbyhospit == '' || getorderbyhospit == null) {
        // if dont search and orderby
        if (widget.provName == '' || widget.provName == null) {
          // if dont search orderby and provName
          print('if dont search orderby and provName');
          response = await http.get(Uri.parse(
              "http://$ipcon/ihelpu/hospital.php?latitudeMe=${latitude}&longtitudeMe=${longitude}"));
        } else {
          // if dont search orderby but have provName
          print('if dont search orderby but have provName');
          response = await http.get(Uri.parse(
              "http://$ipcon/ihelpu/hospital.php?provName=${widget.provName}&latitudeMe=${latitude}&longtitudeMe=${longitude}"));
        }
      } else {
        // if dont search but have orderby and provName
        print('if dont search but have orderby and provName');
        if (widget.provName == '' || widget.provName == null) {
          // dont search provName but orderby
          print('dont search provName but orderby');
          response = await http.get(Uri.parse(
              "http://$ipcon/ihelpu/hospital.php?orderby=${getorderbyhospit}&latitudeMe=${latitude}&longtitudeMe=${longitude}"));
        } else {
          // dont search but have provName and orderby
          print('dont search but have provName and orderby');
          response = await http.get(Uri.parse(
              "http://$ipcon/ihelpu/hospital.php?orderby=${getorderbyhospit}&provName=${widget.provName}&latitudeMe=${latitude}&longtitudeMe=${longitude}"));
        }
      }
    } else {
      // search
      if (getorderbyhospit == '' || getorderbyhospit == null) {
        // if search but dont orderby
        if (widget.provName == '' || widget.provName == null) {
          // if search dont orderby and provName
          print('if search dont orderby and provName');
          response = await http.get(Uri.parse(
              "http://$ipcon/ihelpu/hospital.php?getSearch=${getSearch}&latitudeMe=${latitude}&longtitudeMe=${longitude}"));
        } else {
          // if search but dont orderby but have provName
          print('if search but dont orderby but have provName');
          response = await http.get(Uri.parse(
              "http://$ipcon/ihelpu/hospital.php?provName=${widget.provName}&getSearch=${getSearch}&latitudeMe=${latitude}&longtitudeMe=${longitude}"));
        }
      } else {
        // if search but have orderby
        print('if search but have orderby');
        if (widget.provName == '' || widget.provName == null) {
          // if search have orderby but dont have provName
          print('if search have orderby but dont have provName');
          response = await http.get(Uri.parse(
              "http://$ipcon/ihelpu/hospital.php?orderby=${getorderbyhospit}&getSearch=${getSearch}&latitudeMe=${latitude}&longtitudeMe=${longitude}"));
        } else {
          // if search orderby and provName
          print('if search orderby and provName');
          response = await http.get(Uri.parse(
              "http://$ipcon/ihelpu/hospital.php?orderby=${getorderbyhospit}&provName=${widget.provName}&getSearch=${getSearch}&latitudeMe=${latitude}&longtitudeMe=${longitude}"));
        }
      }
    }

    var jsondata = json.decode(response.body);
    setState(() {
      gethospit = jsondata;
      listlength = gethospit.length;
    });

    return json.decode(response.body);
  }

  List getLocathospi = List.empty();

  // void getLocationhospital(
  //     String hospital_latitude, String hospital_longtitude) async {
  //   final response = await http.get(Uri.parse(
  //       "http://$ipcon/ihelpu/locationhospital.php?latitudeMe=${latitude}&longtitudeMe=${longitude}&hospital_latitude=${hospital_latitude}&hospital_longtitude=${hospital_longtitude}"));
  //   var jsondata = json.decode(response.body);
  //   setState(() {
  //   });

  //   return json.decode(response.body);
  // }

  @override
  void initState() {
    gethospital();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // print(getLocathospi);
    GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    print('จ.' + widget.provName!);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: DrawerGeography(),//ดึงค่าจากจังหวัดมา
        appBar: AppBar(
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
            'ค้นหาโรงพยาบาล',
            style: GoogleFonts.prompt(fontSize: 18, color: Colors.black),
          ),
          actions: [
            IconButton(
              padding: EdgeInsets.only(right: 20),
              icon: Icon(Icons.home_outlined, size: 32),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return MainMenuPage();
                  }),
                );
              },
            ),
            Container(
              padding: EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState!.openEndDrawer();
                  },//เปิดปิดดอเวอร์
                  icon: Icon(CupertinoIcons.slider_horizontal_3),
                  color: Colors.black),
            ),
          ],
        ),
        body: Center(
          child: ListView(
            children: [
              Container(
                height: 70,
                width: double.infinity,
                color: Colors.orange[700],
                child: Container(
                  padding:
                      EdgeInsets.only(top: 15, bottom: 15, right: 15, left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(30),
                    child: TextField(
                      controller: SearchNamehospit,
                      onChanged: (v) {
                        print(SearchNamehospit.text);
                        getSearch = v;
                        print(getSearch);
                      },
                      decoration: InputDecoration(
                        hintText: 'โรงพยาบาลที่ใกล้ฉัน',
                        hintStyle: GoogleFonts.prompt(
                            fontSize: 18, color: Colors.grey),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search_rounded),
                          color: Colors.black,
                          onPressed: () {
                            gethospital();
                          },
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 11.0, vertical: 9.0),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Table(
                  border: TableBorder.all(color: Colors.white),
                  columnWidths: const <int, TableColumnWidth>{
                    0: IntrinsicColumnWidth(),
                    1: FlexColumnWidth(2),
                    2: FixedColumnWidth(2),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[
                    TableRow(
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            color: Colors.red,
                            height: 65,
                            width: size.shortestSide - 225,
                            alignment: Alignment.center,
                            child: Text(
                              'เรียงตามระยะทาง',
                              style: GoogleFonts.prompt(
                                  fontSize: 21, color: Colors.white),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              getorderbyhospit = '';
                            });
                            gethospital();
                          },
                        ),
                        TableCell(
                          // verticalAlignment: TableCellVerticalAlignment.top,
                          child: GestureDetector(
                            child: Container(
                              color: Colors.red,
                              // padding: EdgeInsets.only(top: 0),
                              alignment: Alignment.center,
                              height: 65,
                              child: Text(
                                'เรียงตามตัวอักษร',
                                style: GoogleFonts.prompt(
                                    fontSize: 21, color: Colors.white),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                getorderbyhospit = '1';
                                gethospital();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              HospitalPage(
                  listHospital: gethospit,
                  longitudeMe: longitude,
                  latitudeMe: latitude),
            ],
          ),
        ),
      ),
    );
  }
}

class HospitalPage extends StatelessWidget {
  final longitudeMe;
  final latitudeMe;
  final listHospital;
  HospitalPage(
      {required this.listHospital,
      required this.latitudeMe,
      required this.longitudeMe});

  Future<int> lengthhopital(
      String hospital_latitude, String hospital_longtitude) async {
    final response = await http.get(Uri.parse(
        "http://$ipcon/ihelpu/locationhospital.php?latitudeMe=${latitudeMe}&longtitudeMe=${longitudeMe}&hospital_latitude=${hospital_latitude}&hospital_longtitude=${hospital_longtitude}"));
    var jsondata = json.decode(response.body);
    print(jsondata);

    return json.decode(response.body).round();
  }

  @override
  Widget build(BuildContext context) {
    // print(listHospital);

    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.shortestSide + 140,
      child: ListView.builder(
          itemCount: listHospital == null ? 0 : listHospital.length,
          itemBuilder: (context, i) {
            return Container(
              padding: EdgeInsets.all(4),
              child: GestureDetector(
                onTap: () => _onAlertButtonsPressed(
                    context,
                    listHospital[i]['hospital_name'],
                    listHospital[i]['hospital_tel']),
                child: Card(
                  child: ListTile(
                    leading: Column(
                      children: [
                        Icon(CupertinoIcons.placemark_fill,
                            color: Colors.black, size: 26),
                        Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Container(
                                height: 15,
                                width: 30,
                                child: Text(
                                    listHospital[i]['distance_in_km'] + ' กม.',
                                    style: GoogleFonts.prompt(
                                        fontSize: 12, color: Colors.black)))),
                      ],
                    ),
                    title: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                listHospital[i]['hospital_name'],
                                style: GoogleFonts.prompt(
                                    fontSize: 18, color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                listHospital[i]['hospital_detail'],
                                style: GoogleFonts.prompt(
                                    fontSize: 15, color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  _onAlertButtonsPressed(context, String hostiname, String hospitel) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "คุณแน่ใจที่จะโทรหาหรือไม่",
      desc: hostiname + "\n" + hospitel,
      buttons: [
        DialogButton(
          child: Text(
            "โทร",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          onPressed: () {
            print(hostiname);
            _callNumber(hospitel);
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "ยกเลิก",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
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
