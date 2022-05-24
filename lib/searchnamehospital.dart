import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ihelpu_app/drawergeography.dart';
import 'package:ihelpu_app/ipcon.dart';
import 'package:ihelpu_app/mainmenu.dart';
import 'package:ihelpu_app/searchhospital.dart';

class SearchNameHospital extends StatefulWidget {
  String SearchHospital;
  SearchNameHospital({required this.SearchHospital});

  @override
  _SearchNameHospitalState createState() => _SearchNameHospitalState();
}

class _SearchNameHospitalState extends State<SearchNameHospital> {
  TextEditingController SearchNamehospit = TextEditingController();

  List gethospit = List.empty();

  int listlength = 0;
  String getorderbyhospit = '';

  Future<List> getsearchnamehospital() async {
    final response = await http.get(Uri.parse(
        "http://$ipcon/ihelpu/searchnamehospital.php?SearchName=${widget.SearchHospital}"));
    var jsondata = json.decode(response.body);
    setState(() {
      gethospit = jsondata;
    });
    return json.decode(response.body);
  }

  Future<List> gethospital() async {
    final response = await http.get(Uri.parse(
        "http://$ipcon/ihelpu/hospital.php?orderby=${getorderbyhospit}"));
    var jsondata = json.decode(response.body);
    setState(() {
      gethospit = jsondata;
      listlength = gethospit.length;
    });

    // for(int i=0;i<gethospit.length;i++){
    //   getLocationhospital(gethospit[i]['hospital_latitude'],gethospit[i]['hospital_longtitude']);
    //   print('loop for');
    // }

    return json.decode(response.body);
  }

  @override
  void initState() {
    getsearchnamehospital();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: DrawerGeography(),
        appBar: AppBar(
          leading: IconButton(
            padding: EdgeInsets.only(right: 0),
            icon: Icon(CupertinoIcons.arrow_left, size: 23),
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
              // color: Colors.orange[700],
              // height: 70,
              // width: 67.4,
              padding: EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState!.openEndDrawer();
                  },
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
                width: 325,
                color: Colors.orange[700],
                child: Container(
                  padding:
                      EdgeInsets.only(top: 15, bottom: 15, right: 15, left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(30),
                    child: TextField(
                      controller: SearchNamehospit,
                      decoration: InputDecoration(
                        hintText: 'โรงพยาบาลที่ใกล้ฉัน',
                        hintStyle: GoogleFonts.prompt(
                            fontSize: 18, color: Colors.grey),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search_rounded),
                          color: Colors.black,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SearchNameHospital(
                                        SearchHospital: SearchNamehospit.text),
                              ),
                            );
                          },
                        ),
                        border: InputBorder.none,
                        // borderRadius: BorderRadius.circular(30)),
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
                            // padding: EdgeInsets.only(top: 0),
                            color: Colors.red,
                            height: 65,
                            width: 195,
                            alignment: Alignment.center,
                            child: Text(
                              'เรียงตามระยะทาง',
                              style: GoogleFonts.prompt(
                                  fontSize: 21, color: Colors.white),
                            ),
                          ),
                          onTap: () {},
                        ),
                        TableCell(
                          // verticalAlignment: TableCellVerticalAlignment.top,
                          child: GestureDetector(
                            child: Container(
                              color: Colors.blueGrey[700],
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
              HospitalPage(listHospital: gethospit),
            ],
          ),
        ),
      ),
    );
  }
}

class HospitalPage extends StatelessWidget {
  final listHospital;
  HospitalPage({required this.listHospital});

  @override
  Widget build(BuildContext context) {
    print(listHospital);

    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.shortestSide + 140,
      child: ListView.builder(
          itemCount: listHospital == null ? 0 : listHospital.length,
          itemBuilder: (context, i) {
            return Container(
              padding: EdgeInsets.all(3),
              child: GestureDetector(
                onTap: () {},
                child: Card(
                  child: ListTile(
                    leading: Column(
                      children: [
                        Icon(CupertinoIcons.placemark_fill,
                            color: Colors.black, size: 26),
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text('data',
                              style: GoogleFonts.prompt(
                                  fontSize: 14, color: Colors.black)),
                        ),
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
}
