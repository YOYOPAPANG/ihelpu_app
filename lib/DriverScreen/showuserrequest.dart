// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ihelpu_app/DriverScreen/map_util.dart';
import 'package:ihelpu_app/ipcon.dart';
import 'package:ihelpu_app/searchhospital.dart';

// class GoogleMap extends StatelessWidget {
//   const GoogleMap({Key? key, TextButton child}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(

//     ));
//   }
// }

class ShowUserRequest extends StatefulWidget {
  final list;
  final i;
  ShowUserRequest({this.list, this.i});

  @override
  _ShowUserRequestState createState() => _ShowUserRequestState();
}

class _ShowUserRequestState extends State<ShowUserRequest> {
  List addDataloca = [];
  List<Marker> locat = [];

  Future<List> addDatalocat() async {
    final response = await http.get(Uri.parse(
        "http://$ipcon/ihelpu/driverscreen/showrequestuserlocal.php?request_id=${widget.list[widget.i]['request_id']}"));
    var addDatalocat = json.decode(response.body);

    setState(() {
      addDataloca = addDatalocat;
    });

    String addData1 = addDataloca[0]['request_locat'];
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

  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(widget.list[widget.i]['user_lat']);
    print(widget.list[widget.i]['user_lng']);
    return SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60.0),
              child: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  widget.list[0]['user_username'] + ' ขอความช่วยเหลือ ',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                centerTitle: true,
                backgroundColor: Colors.greenAccent[400],
                leading: IconButton(
                  padding: EdgeInsets.only(top: 5, left: 15),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(CupertinoIcons.arrow_turn_down_left),
                ),
              ),
            ),
            body: Column(
              children: [
                SizedBox(height: 50),
                Container(
                  height: size.shortestSide + 150,
                  width: double.infinity,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          double.parse(widget.list[widget.i]['user_lat']),
                          double.parse(widget.list[widget.i]
                              ['user_lng'])), //กำหนดพิกัดเริ่มต้นบนแผนที่
                      zoom: 15, //กำหนดระยะการซูม กำหนดได้ 0-20
                    ),
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    markers: {
                      Marker(
                          markerId: MarkerId('Test01'),
                          position: LatLng(
                              double.parse(widget.list[widget.i]['user_lat']),
                              double.parse(widget.list[widget.i]['user_lng'])),
                          infoWindow: InfoWindow(
                              title: 'ชื่อ : ' +
                                  widget.list[widget.i]['user_fullname'],
                              snippet: 'ประเภท : ' +
                                  widget.list[widget.i]['request_type']))
                    },
                    // onMapCreated: (GoogleMapController controller) {
                    //   _controller.complete(controller);
                    // },
                  ),
                ),
                Container(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.greenAccent[400]),
                    onPressed: () {
                      MapUtil.openMap(//ส่งพิกัดไปกูเกิลแมพ
                          double.parse(widget.list[widget.i]['user_lat']),
                          double.parse(widget.list[widget.i]['user_lng']));
                    },
                    child: Text(
                      'เปิดแผนที่',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
