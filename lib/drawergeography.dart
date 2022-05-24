import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ihelpu_app/ipcon.dart';
import 'package:http/http.dart' as http;
import 'package:ihelpu_app/searchhospital.dart';

class DrawerGeography extends StatefulWidget {

  @override
  _DrawerGeographyState createState() => _DrawerGeographyState();
}

class _DrawerGeographyState extends State<DrawerGeography> {
  List geo = [''];
  bool Loading = true;

  List geo1 = [''];
  List geo2 = [''];
  List geo3 = [''];
  List geo4 = [''];
  List geo5 = [''];
  List geo6 = [''];

  String selectprovin01 = '';

  Future<List> getGeography() async {
    final response =
        await http.get(Uri.parse("http://$ipcon/ihelpu/drawergeography.php"));
    var jsondata = json.decode(response.body);
    setState(() {
      Loading = false;
      geo = jsondata;
    });
    getprovinces1();
    getprovinces2();
    getprovinces3();
    getprovinces4();
    getprovinces5();
    getprovinces6();
    return json.decode(response.body);
  }

  Future<List> getprovinces1() async {
    final response = await http.get(Uri.parse(
        "http://$ipcon/ihelpu/drawerprovinces.php?provinces=${geo[0]['geo_id']}"));
    var jsondata = json.decode(response.body);
    setState(() {
      Loading = false;
      geo1 = jsondata;
    });

    return json.decode(response.body);
  }

  Future<List> getprovinces2() async {
    final response = await http.get(Uri.parse(
        "http://$ipcon/ihelpu/drawerprovinces.php?provinces=${geo[1]['geo_id']}"));
    var jsondata = json.decode(response.body);
    setState(() {
      Loading = false;
      geo2 = jsondata;
    });

    return json.decode(response.body);
  }

  Future<List> getprovinces3() async {
    final response = await http.get(Uri.parse(
        "http://$ipcon/ihelpu/drawerprovinces.php?provinces=${geo[2]['geo_id']}"));
    var jsondata = json.decode(response.body);
    setState(() {
      Loading = false;
      geo3 = jsondata;
    });

    return json.decode(response.body);
  }

  Future<List> getprovinces4() async {
    final response = await http.get(Uri.parse(
        "http://$ipcon/ihelpu/drawerprovinces.php?provinces=${geo[3]['geo_id']}"));
    var jsondata = json.decode(response.body);
    setState(() {
      Loading = false;
      geo4 = jsondata;
    });

    return json.decode(response.body);
  }

  Future<List> getprovinces5() async {
    final response = await http.get(Uri.parse(
        "http://$ipcon/ihelpu/drawerprovinces.php?provinces=${geo[4]['geo_id']}"));
    var jsondata = json.decode(response.body);
    setState(() {
      Loading = false;
      geo5 = jsondata;
    });

    return json.decode(response.body);
  }

  Future<List> getprovinces6() async {
    final response = await http.get(Uri.parse(
        "http://$ipcon/ihelpu/drawerprovinces.php?provinces=${geo[5]['geo_id']}"));
    var jsondata = json.decode(response.body);
    setState(() {
      Loading = false;
      geo6 = jsondata;
    });

    return json.decode(response.body);
  }

  @override
  void initState() {
    getGeography();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Loading
        ? CircularProgressIndicator()
        : Container(
            padding: EdgeInsets.all(20),
            // height: size.shortestSide + 100,
            // width: size.shortestSide + 150,
            child: ListView(children: [
              Container(
                // height: 300,
                // width: 250,
                color: Colors.white,
                child: ExpansionTile(
                  title: Text(
                    'ภาคเหนือ',
                    style: GoogleFonts.prompt(fontSize: 18),
                  ),
                  children: [
                    Container(
                      height: size.shortestSide - 100,
                      child: ListView.builder(
                          itemCount: geo1 == null ? 0 : geo1.length,
                          itemBuilder: (context, i) {
                            return Loading
                                ? CircularProgressIndicator()
                                : Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: ListTile(
                                      title: Text(
                                        geo1[i]['province_name'],
                                        style: GoogleFonts.prompt(fontSize: 14),
                                      ),
                                      trailing:
                                          Icon(CupertinoIcons.chevron_forward, size: 14),
                                      onTap: () {
                                        print(geo1[i]['province_id']);
                                        Navigator.push(context,
                                        MaterialPageRoute(
                                          builder: (context) => SearchHospitalPage(
                                            provName: geo1[i]['province_id'])));
                                        // setState(() {
                                        //   selectprovin01 = geo1[i]['provinces_id'];
                                        // });
                                      },
                                    ),
                                  );
                          }),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: ExpansionTile(
                  title: Text(
                    'ภาคกลาง',
                    style: GoogleFonts.prompt(fontSize: 18),
                  ),
                  children: [
                    Container(
                      height: size.shortestSide - 100,
                      child: ListView.builder(
                          itemCount: geo2 == null ? 0 : geo2.length,
                          itemBuilder: (context, i) {
                            return Loading
                                ? CircularProgressIndicator()
                                : Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: ListTile(
                                      title: Text(
                                        geo2[i]['province_name'],
                                        style: GoogleFonts.prompt(fontSize: 14),
                                      ),
                                      trailing:
                                          Icon(CupertinoIcons.chevron_forward, size: 14),
                                      onTap: () {
                                         print(geo2[i]['province_id']);
                                        Navigator.push(context,
                                        MaterialPageRoute(
                                          builder: (context) => SearchHospitalPage(
                                            provName: geo2[i]['province_id'])));
                                      },
                                    ),
                                  );
                          }),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: ExpansionTile(
                  title: Text(
                    'ภาคตะวันออกเฉียงเหนือ',
                    style: GoogleFonts.prompt(fontSize: 18),
                  ),
                  children: [
                    Container(
                      height: size.shortestSide - 100,
                      child: ListView.builder(
                          itemCount: geo3 == null ? 0 : geo3.length,
                          itemBuilder: (context, i) {
                            return Loading
                                ? CircularProgressIndicator()
                                : Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: ListTile(
                                      title: Text(
                                        geo3[i]['province_name'],
                                        style: GoogleFonts.prompt(fontSize: 14),
                                      ),
                                      trailing:
                                          Icon(CupertinoIcons.chevron_forward, size: 14),
                                      onTap: () {
                                         print(geo3[i]['province_id']);
                                        Navigator.push(context,
                                        MaterialPageRoute(
                                          builder: (context) => SearchHospitalPage(
                                            provName: geo3[i]['province_id'])));
                                      },
                                    ),
                                  );
                          }),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: ExpansionTile(
                  title: Text(
                    'ภาคตะวันตก',
                    style: GoogleFonts.prompt(fontSize: 18),
                  ),
                  children: [
                    Container(
                      height: size.shortestSide - 100,
                      child: ListView.builder(
                          itemCount: geo4 == null ? 0 : geo4.length,
                          itemBuilder: (context, i) {
                            return Loading
                                ? CircularProgressIndicator()
                                : Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: ListTile(
                                      title: Text(
                                        geo4[i]['province_name'],
                                        style: GoogleFonts.prompt(fontSize: 14),
                                      ),
                                      trailing:
                                          Icon(CupertinoIcons.chevron_forward, size: 14),
                                      onTap: () {
                                         print(geo4[i]['province_id']);
                                        Navigator.push(context,
                                        MaterialPageRoute(
                                          builder: (context) => SearchHospitalPage(
                                            provName: geo4[i]['province_id'])));
                                      },
                                    ),
                                  );
                          }),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: ExpansionTile(
                  title: Text(
                    'ภาคตะวันออก',
                    style: GoogleFonts.prompt(fontSize: 18),
                  ),
                  children: [
                    Container(
                      height: size.shortestSide - 100,
                      child: ListView.builder(
                          itemCount: geo5 == null ? 0 : geo5.length,
                          itemBuilder: (context, i) {
                            return Loading
                                ? CircularProgressIndicator()
                                : Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: ListTile(
                                      title: Text(
                                        geo5[i]['province_name'],
                                        style: GoogleFonts.prompt(fontSize: 14),
                                      ),
                                      trailing:
                                          Icon(CupertinoIcons.chevron_forward, size: 14),
                                      onTap: () {
                                         print(geo5[i]['province_id']);
                                        Navigator.push(context,
                                        MaterialPageRoute(
                                          builder: (context) => SearchHospitalPage(
                                            provName: geo5[i]['province_id'])));
                                      },
                                    ),
                                  );
                          }),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: ExpansionTile(
                  title: Text(
                    'ภาคใต้',
                    style: GoogleFonts.prompt(fontSize: 18),
                  ),
                  children: [
                    Container(
                      height: size.shortestSide - 100,
                      child: ListView.builder(
                          itemCount: geo6 == null ? 0 : geo6.length,
                          itemBuilder: (context, i) {
                            return Loading
                                ? CircularProgressIndicator()
                                : Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: ListTile(
                                      title: Text(
                                        geo6[i]['province_name'],
                                        style: GoogleFonts.prompt(fontSize: 14),
                                      ),
                                      trailing:
                                          Icon(CupertinoIcons.chevron_forward, size: 14),
                                      onTap: () {
                                         print(geo6[i]['province_id']);
                                        Navigator.push(context,
                                        MaterialPageRoute(
                                          builder: (context) => SearchHospitalPage(
                                            provName: geo6[i]['province_id'])));
                                      },
                                    ),
                                  );
                          }),
                    ),
                  ],
                ),
              ),
            ]),
          );
  }
}
