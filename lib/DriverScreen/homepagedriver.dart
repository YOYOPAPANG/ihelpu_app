// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, must_be_immutable, avoid_print, sized_box_for_whitespace, non_constant_identifier_names, unused_local_variable

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ihelpu_app/DriverScreen/case_screen.dart';
import 'package:ihelpu_app/DriverScreen/drawermaindriver.dart';
import 'package:ihelpu_app/DriverScreen/showuserrequest.dart';
import 'package:ihelpu_app/ipcon.dart';
import 'package:ihelpu_app/searchhospital.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomepageDriver extends StatefulWidget {
  @override
  _HomepageDriverState createState() => _HomepageDriverState();
}

class _HomepageDriverState extends State<HomepageDriver> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String latlonglocal = '';

  Future<List> getdata() async {
    final response = await http.get(
        Uri.parse("http://$ipcon/ihelpu/driverscreen/showrequestuser.php"));
    return json.decode(response.body);
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
    return SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            drawer: DrawerMaindriver(),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60.0),
              child: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  'Driver ihelp U',
                  style: TextStyle(color: Colors.white, fontSize: 36),
                ),
                centerTitle: true,
                backgroundColor: Colors.greenAccent[400],
                leading: IconButton(
                  padding: EdgeInsets.only(top: 5, left: 15),
                  onPressed: () {
                    return _scaffoldKey.currentState!.openDrawer();
                  },
                  icon: Icon(Icons.menu, size: 36),
                ),
              ),
            ),
            body: Container(
              child: FutureBuilder<List>(
                future: getdata(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Itemlist(
                        list: snapshot.data, latlonglocal: latlonglocal);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )));
  }
}

class Itemlist extends StatefulWidget {
  final list;
  String? latlonglocal;
  Itemlist({this.list, this.latlonglocal});

  @override
  _ItemlistState createState() => _ItemlistState();
}

class _ItemlistState extends State<Itemlist> {
  void accpetdriver(
      {String? officer_lat, String? officer_lng, String? request_id}) async {
    print("accpetdriver");
    String _dusername = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _dusername = preferences.getString('officer_username')!;
    print(_dusername);
    print(request_id);

    var url =
        Uri.parse("http://$ipcon/ihelpu/driverscreen/acceprequestdriver.php");
    var response = await http.post(url, body: {
      "request_status": "1",
      "request_id": request_id,
      "officer_id": _dusername,
      "officer_lat": latitude.toString(),
      "officer_lng": longitude.toString()
    });
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return CaseScreen(
        request_id: request_id,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list == null ? 0 : widget.list.length,
      itemBuilder: (context, i) {
        return Container(
          height: 120,
          child: Padding(
            padding: EdgeInsets.only(left: 10, bottom: 5, right: 10, top: 15),
            child: Card(
              child: ListTile(
                onTap: () {
                  print(widget.list[i]['request_id']);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return ShowUserRequest(list: widget.list, i: i);
                  }));
                },
                title: Text(widget.list[i]['user_tel'] +
                    "\n" +
                    'ชื่อ: ' +
                    widget.list[i]['user_fullname'] +
                    "\n" +
                    'ประเภท: ' +
                    widget.list[i]['request_type']),
                trailing: Wrap(
                  children: [
                    IconButton(
                      color: Colors.green,
                      icon: Icon(Icons.add_task),
                      onPressed: () {
                        accpetdriver(
                            officer_lat: latitude,
                            officer_lng: longitude,
                            request_id: widget.list[i]['request_id']);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
