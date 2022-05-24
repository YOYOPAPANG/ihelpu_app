import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:ihelpu_app/ipcon.dart';
import 'package:ihelpu_app/mainmenu.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

  //หน้านี้ไม่ใช่แล้ว XXX

class SearchNameEmerPage extends StatefulWidget {

  String SearchNameEmercall;
  SearchNameEmerPage({required this.SearchNameEmercall});

  @override
  _SearchNameEmerPageState createState() => _SearchNameEmerPageState();
}

class _SearchNameEmerPageState extends State<SearchNameEmerPage> {
  TextEditingController SearchNameEmer = TextEditingController();

  String searchNameEmer = '';

  Future<List> getEmerCall2() async {
    final response = await http.get(Uri.parse(
        "http://$ipcon/ihelpu/SearchNameEmercall.php?SearchName=${widget.SearchNameEmercall}"));
    setState(() {});
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'สายด่วนสำหรับเหตุด่วนเหตุร้าย',
            style: GoogleFonts.prompt(fontSize: 18, color: Colors.black),
          ),
          actions: [
            IconButton(
              padding: EdgeInsets.only(right: 32),
              icon: Icon(Icons.home_outlined, size: 34),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return MainMenuPage();
                  }),
                );
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
                        borderRadius: BorderRadius.circular(30),
                        child: TextField(
                          controller: SearchNameEmer,
                          decoration: InputDecoration(
                            hintText: 'ค้นหาสายฉุกเฉิน',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search_rounded),
                              color: Colors.black,
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (BuildContext context) =>
                                //           SearchNameEmerPage(
                                //               SearchNameEmercall:
                                //                   SearchNameEmer.text),
                                //     ));
                                setState(() {
                                  searchNameEmer = SearchNameEmer.text;
                                });
                              },
                            ),
                            border: InputBorder.none,
                            // borderRadius: BorderRadius.circular(30)),
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

  TextEditingController SearchNameEmer = TextEditingController();

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
      desc: Emername,
      buttons: [
        DialogButton(
          child: Text(
            "Call" + "\n" + EmerTel,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          onPressed: () async {
            print(EmerTel);
            FlutterPhoneDirectCaller.callNumber(EmerTel);
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



// _launchPhoneURL(String phoneNumber) async {
//   String url = 'tel:' + phoneNumber;
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
