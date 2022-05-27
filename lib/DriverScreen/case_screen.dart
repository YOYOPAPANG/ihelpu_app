// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, non_constant_identifier_names, must_be_immutable, avoid_print, unnecessary_brace_in_string_interps, deprecated_member_use, avoid_unnecessary_containers, unused_element, unrelated_type_equality_checks, prefer_final_fields, unused_local_variable
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ihelpu_app/DriverScreen/success_screen.dart';
import 'package:ihelpu_app/searchhospital.dart';
import '../ipcon.dart';

class CaseScreen extends StatefulWidget {
  String? request_id;
  CaseScreen({Key? key, required this.request_id}) : super(key: key);

  @override
  State<CaseScreen> createState() => _CaseScreenState();
}

class _CaseScreenState extends State<CaseScreen> {
  GoogleMapController? mapController;
  List dataList = [];
  List officerList = [];
  List userList = [];
  String? request_type;
  String? officer_id;
  String? officer_fullname;
  String? user_id;
  String? user_fullname;
  String? user_sex;
  String? user_age;
  String? user_tel;
  String? officer_img;
  String? user_img;
  String? lat;
  String? lng;
  bool status = false;
  Position? driverLocation;
  Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId('id-1'),
            position: LatLng(
                double.parse(lat.toString()), double.parse(lng.toString())),
            infoWindow: InfoWindow(
              title: 'ผู้ป่วย',
            )),
      );
    });
  }

  Future<List> getdata() async {
    final response = await http.get(Uri.parse(
        "http://$ipcon/ihelpu/driverscreen/getdata.php?request_id=${widget.request_id}"));
    var data = json.decode(response.body);
    setState(() {
      dataList = data;
      request_type = dataList[0]['request_type'];
      officer_id = dataList[0]['officer_id'];
      user_id = dataList[0]['user_id'];
      lat = dataList[0]['user_lat'];
      lng = dataList[0]['user_lng'];
    });
    //print(data);
    //get_data_officer();
    //get_data_user();
    return data;
  }

  get_data_officer() async {
    final response = await http.get(Uri.parse(
        "http://$ipcon/ihelpu/driverscreen/getdata_officer.php?officer_id=${officer_id}"));
    var data2 = json.decode(response.body);
    // print(data2);
    setState(() {
      officerList = data2;
      officer_fullname = officerList[0]['officer_fullname'];
      officer_img = officerList[0]['officer_images'];
    });
  }

  get_data_user() async {
    final response = await http.get(Uri.parse(
        "http://$ipcon/ihelpu/driverscreen/getdata_user.php?user_id=${user_id}"));
    var data3 = json.decode(response.body);
    //  print(data3);
    setState(() {
      userList = data3;
      user_fullname = userList[0]['user_fullname'];
      user_sex = userList[0]['user_sex'];
      user_age = userList[0]['user_age'];
      user_tel = userList[0]['user_tel'];
      user_img = userList[0]['user_images'];
    });
  }

  _getLocation() async {
    driverLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    return driverLocation;
  }

  success(String request_id) async {
    print("successed");
    print(request_id);
    final response = await http.get(Uri.parse(
        "http://$ipcon/ihelpu/driverscreen/success.php?request_id=${request_id}"));
  }

  @override
  void initState() {
    //getdata();
    _getLocation();

    super.initState();
  }

  Future<void> updateofficerlocal(String officer_id) async {
    print("updating");
    getCurrentLocation((latO, longO) async {
      final response = await http.post(
          Uri.parse("http://$ipcon/ihelpu/driverscreen/updateofficerlocal.php"),
          body: {"officer_id": officer_id, "lat": latO, "lng": longO});
    });

    // print(data2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List>(
        future: getdata(),
        builder: (context, data) {
          // ส่งค่าที่อยู่ไหม่ของเจ้าหน้าที่เก็บไว้ที่database ไว้ให้userเห็นตำแหน่งไหม่ของเจ้าหน้าที่
          // ถ้าErrorหรือหมุนค้างก็ปิดไปก็ได้
          if (data.hasData && driverLocation != null) {
            updateofficerlocal(data.data![0]['officer_id']);
          }

          return data.hasData && driverLocation != null
              ? Stack(
                  children: [
                    SafeArea(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Color(0xff2e323b),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    color: Color(0xff01b240),
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: 110,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 30,
                                          left: 15,
                                          child: officer_img == ''
                                              ? CircleAvatar(
                                                  backgroundColor: Colors.grey,
                                                  radius: 30,
                                                  backgroundImage: AssetImage(
                                                      "assets/images/profile.jpg"),
                                                )
                                              : CircleAvatar(
                                                  backgroundColor: Colors.grey,
                                                  radius: 30,
                                                  backgroundImage: NetworkImage(
                                                      "http://$ipcon/ihelpu/upload/${data.data![0]['officer_images']}"),
                                                ),
                                        ),
                                        Positioned(
                                          top: 30,
                                          left: 95,
                                          child: Column(
                                            children: [
                                              Text(
                                                "เจ้าหน้าที่",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                "${data.data![0]['officer_fullname']}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Color(0xff606060),
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: 110,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 30,
                                          left: 15,
                                          child: user_img == ''
                                              ? CircleAvatar(
                                                  backgroundColor: Colors.grey,
                                                  radius: 30,
                                                  backgroundImage: AssetImage(
                                                      "assets/images/profile.jpg"),
                                                )
                                              : CircleAvatar(
                                                  backgroundColor: Colors.grey,
                                                  radius: 30,
                                                  backgroundImage: NetworkImage(
                                                      "http://$ipcon/ihelpu/upload/${data.data![0]['user_images']}"),
                                                ),
                                        ),
                                        Positioned(
                                          top: 30,
                                          left: 95,
                                          child: Column(
                                            children: [
                                              Text(
                                                "ผู้ใช้งาน",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                "${data.data![0]['user_fullname']}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                color: Color(0xff394053),
                                height:
                                    MediaQuery.of(context).size.height * 0.16,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "ชื่อ : ${data.data![0]['user_fullname']} เพศ : ${data.data![0]['user_sex']} ",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 19),
                                    ),
                                    Text(
                                        "ประเภท : ${data.data![0]['request_type']}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 19)),
                                    Text("เบอร์ : ${data.data![0]['user_tel']}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 19)),
                                    Text(
                                        "เบอร์ญาติ : ${data.data![0]['relation_tel']}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 19)),
                                  ],
                                ),
                              ),
                              Container(
                                color: Colors.blue,
                                height:
                                    MediaQuery.of(context).size.height * 0.42,
                                width: MediaQuery.of(context).size.width,
                                child: GoogleMap(
                                  markers: _markers,
                                  zoomControlsEnabled: true,
                                  mapType: MapType.normal,
                                  myLocationButtonEnabled: true,
                                  myLocationEnabled: true,
                                  onMapCreated: _onMapCreated,
                                  initialCameraPosition: CameraPosition(
                                      target: LatLng(driverLocation!.latitude,
                                          driverLocation!.longitude),
                                      zoom: 15),
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SimpleDialog(
                                              title: Text(
                                                  'โทรหาผู้ขอความช่วยเหลือ'),
                                              contentPadding:
                                                  EdgeInsets.all(20),
                                              children: [
                                                Text(
                                                    'คุณต้องการโทรหาผู้ขอความช่วยเหลือหรือไม่?'),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {
                                                        _callNumber(data
                                                            .data![0]
                                                                ['user_tel']
                                                            .toString());
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('โทร'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('ปิด'),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 10),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 60,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                              color: Color(0xff00b240)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "ติดต่อผู้ขอความช่วยเหลือ",
                                                style: TextStyle(
                                                    fontSize: 23,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Icon(
                                                Icons.phone,
                                                size: 30,
                                                color: Color(0xffe64d3e),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          status = true;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 10),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(22),
                                            color: Color(0xffff8b3c),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "ช่วยเหลือสำเร็จแล้ว",
                                                style: TextStyle(
                                                    fontSize: 23,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: status == true ? true : false,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.black87,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print(data.data);
                                  success(data.data![0]['request_id_prime']);
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return SuccessScreen();
                                  }));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22),
                                      color: Color(0xffff8b3c),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "ยืนยันการช่วยเหลือสำเร็จ",
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22),
                                      color: Color(0xfffe0000)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            status = false;
                                          });
                                        },
                                        child: Text(
                                          "ยกเลิก",
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
        },
      ),
    );
  }
}

_callNumber(String phoneNumber) async {
  String number = phoneNumber;
  await FlutterPhoneDirectCaller.callNumber(number);
}
