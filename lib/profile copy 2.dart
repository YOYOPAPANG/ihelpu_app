// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:projectihelpu/editpass.dart';
// import 'package:projectihelpu/editprofile.dart';
// import 'package:projectihelpu/ipcon.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   String username = "";

//   Future getUserid() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     setState(() {
//       username = preferences.getString('user_username')!;
//     });
//   }

//   Future<List> getFullname() async {
//     final response = await http.get(
//         Uri.parse("http://$ipcon/ihelpu/getuserid.php?user_id=${username}"));
//     setState(() {});
//     return json.decode(response.body);
//   }

//   @override
//   void initState() {
//     getUserid();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         appBar: AppBar(
//           title: Text("Account"),
//           centerTitle: true,
//           leading: IconButton(
//             icon: Icon(CupertinoIcons.arrow_turn_down_left),
//             onPressed: () {
//               return Navigator.pop(context);
//             },
//           ),
//           automaticallyImplyLeading: false,
//           backgroundColor: Colors.orange[600],
//         ),
//         body: FutureBuilder<List>(
//             future: getFullname(),
//             builder: (context, data) {
//             return data.hasData ? ListView(
//             children: [
//             Container(
//                 color: Colors.white,
//                 child: new ListView(
//                   children: <Widget>[
//                     Column(
//                       children: <Widget>[
//                         new Container(
//                           height: 250.0,
//                           color: Colors.white,
//                           child: new Column(
//                             children: <Widget>[
//                               Padding(
//                                   padding:
//                                       EdgeInsets.only(left: 20.0, top: 20.0),
//                                   child: new Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                   )),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 20.0),
//                                 child: new Stack(
//                                     fit: StackFit.loose,
//                                     children: <Widget>[
//                                       new Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: <Widget>[
//                                           new Container(
//                                               width: 140.0,
//                                               height: 140.0,
//                                               decoration: new BoxDecoration(
//                                                 shape: BoxShape.circle,
//                                                 image: new DecorationImage(
//                                                   image: new ExactAssetImage(
//                                                       'assets/lodo.png'),
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                               )),
//                                         ],
//                                       ),
//                                       Padding(
//                                           padding: EdgeInsets.only(
//                                               top: 90.0, right: 100.0),
//                                           child: new Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: <Widget>[
//                                               new CircleAvatar(
//                                                 backgroundColor: Colors.red,
//                                                 radius: 25.0,
//                                                 child: new Icon(
//                                                   Icons.camera_alt,
//                                                   color: Colors.white,
//                                                 ),
//                                               )
//                                             ],
//                                           )),
//                                     ]),
//                               )
//                             ],
//                           ),
//                         ),
//                         new Container(
//                           color: Color(0xffFFFFFF),
//                           child: Padding(
//                             padding: EdgeInsets.only(bottom: 25.0),
//                             child: new Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: <Widget>[
//                                 Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 153.0, right: 153.0, top: 25.0),
//                                     child: new Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: <Widget>[
//                                         new Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: <Widget>[
//                                             new Text(
//                                               'ข้อมูลส่วนตัว',
//                                               style: TextStyle(
//                                                   fontSize: 18.0,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ],
//                                         ),
//                                         new Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: <Widget>[],
//                                         )
//                                       ],
//                                     )),
//                                 Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 25.0, right: 25.0, top: 25.0),
//                                     child: new Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: <Widget>[
//                                         new Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: <Widget>[
//                                             new Text(
//                                               'ชื่อ - นามสกุล',
//                                               style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     )),
//                                 Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 25.0, right: 25.0, top: 2.0),
//                                     child: new Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: <Widget>[
//                                         new Flexible(
//                                           child: new TextField(
//                                             decoration: const InputDecoration(),
//                                           ),
//                                         ),
//                                       ],
//                                     )),
//                                 Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 25.0, right: 25.0, top: 25.0),
//                                     child: new Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: <Widget>[
//                                         new Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: <Widget>[
//                                             new Text(
//                                               'วันเดือนปีเกิด',
//                                               style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     )),
//                                 Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 25.0, right: 25.0, top: 2.0),
//                                     child: new Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: <Widget>[
//                                         new Flexible(
//                                           child: new TextField(
//                                             decoration: const InputDecoration(),
//                                           ),
//                                         ),
//                                       ],
//                                     )),
//                                 Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 25.0, right: 25.0, top: 25.0),
//                                     child: new Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: <Widget>[
//                                         new Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: <Widget>[
//                                             new Text(
//                                               'อีเมล',
//                                               style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     )),
//                                 Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 25.0, right: 25.0, top: 2.0),
//                                     child: new Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: <Widget>[
//                                         new Flexible(
//                                           child: new TextField(
//                                             decoration: const InputDecoration(),
//                                           ),
//                                         ),
//                                       ],
//                                     )),
//                                 Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 25.0, right: 25.0, top: 25.0),
//                                     child: new Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: <Widget>[
//                                         new Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: <Widget>[
//                                             new Text(
//                                               'เบอร์โทรศัพท์',
//                                               style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     )),
//                                 Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 25.0, right: 25.0, top: 2.0),
//                                     child: new Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: <Widget>[
//                                         Flexible(
//                                           child: Padding(
//                                             padding:
//                                                 EdgeInsets.only(right: 10.0),
//                                             child: new TextField(
//                                               decoration:
//                                                   const InputDecoration(),
//                                             ),
//                                           ),
//                                           flex: 2,
//                                         ),
//                                       ],
//                                     )),
//                                 Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 25.0, right: 25.0, top: 25.0),
//                                     child: new Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: <Widget>[
//                                         new Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: <Widget>[
//                                             new Text(
//                                               'น้ำหนัก',
//                                               style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     )),
//                                 Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 25.0, right: 25.0, top: 2.0),
//                                     child: new Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: <Widget>[
//                                         new Flexible(
//                                           child: new TextField(
//                                             decoration: const InputDecoration(),
//                                           ),
//                                         ),
//                                       ],
//                                     )),
//                                 Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 25.0, right: 25.0, top: 25.0),
//                                     child: new Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: <Widget>[
//                                         new Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: <Widget>[
//                                             new Text(
//                                               'ส่วนสูง',
//                                               style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     )),
//                                 Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 25.0, right: 25.0, top: 2.0),
//                                     child: new Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: <Widget>[
//                                         new Flexible(
//                                           child: new TextField(
//                                             decoration: const InputDecoration(),
//                                           ),
//                                         ),
//                                       ],
//                                     )),
//                                 Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 25.0, right: 25.0, top: 25.0),
//                                     child: new Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: <Widget>[
//                                         new Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: <Widget>[
//                                             new Text(
//                                               'การแพ้ยา',
//                                               style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     )),
//                                 Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 25.0, right: 25.0, top: 2.0),
//                                     child: new Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: <Widget>[
//                                         new Flexible(
//                                           child: new TextField(
//                                             decoration: const InputDecoration(),
//                                           ),
//                                         ),
//                                       ],
//                                     )),
//                                 Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 25.0, right: 25.0, top: 25.0),
//                                     child: new Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: <Widget>[
//                                         new Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: <Widget>[
//                                             new Text(
//                                               'ที่อยู่',
//                                               style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     )),
//                                 Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 25.0, right: 25.0, top: 2.0),
//                                     child: new Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: <Widget>[
//                                         new Flexible(
//                                           child: new TextField(
//                                             decoration: const InputDecoration(),
//                                           ),
//                                         ),
//                                       ],
//                                     )),
//                                 Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 160.0, right: 160.0, top: 30.0),
//                                     child: new Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: <Widget>[
//                                         new Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: <Widget>[
//                                             new Text(
//                                               'ข้อมูลญาติ',
//                                               style: TextStyle(
//                                                   fontSize: 18.0,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ],
//                                         ),
//                                         new Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: <Widget>[],
//                                         )
//                                       ],
//                                     )),
//                                 Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 25.0, right: 25.0, top: 2.0),
//                                     child: new Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: <Widget>[
//                                         new Flexible(
//                                           child: new TextField(
//                                             decoration: const InputDecoration(),
//                                           ),
//                                         ),
//                                       ],
//                                     )),
//                                 Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 25.0, right: 25.0, top: 25.0),
//                                     child: new Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: <Widget>[
//                                         new Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: <Widget>[
//                                             new Text(
//                                               'ชื่อนามสกุล ญาติ',
//                                               style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     )),
//                                 Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 25.0, right: 25.0, top: 2.0),
//                                     child: new Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: <Widget>[
//                                         new Flexible(
//                                           child: new TextField(
//                                             decoration: const InputDecoration(),
//                                           ),
//                                         ),
//                                       ],
//                                     )),
//                                 Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 25.0, right: 25.0, top: 25.0),
//                                     child: new Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: <Widget>[
//                                         new Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: <Widget>[
//                                             new Text(
//                                               'ความสัมพันธ์',
//                                               style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     )),
//                                 Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 25.0, right: 25.0, top: 2.0),
//                                     child: new Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: <Widget>[
//                                         new Flexible(
//                                           child: new TextField(
//                                             readOnly: true,
//                                             decoration: const InputDecoration(),
//                                           ),
//                                         ),
//                                       ],
//                                     )),
//                                 Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 25.0, right: 25.0, top: 25.0),
//                                     child: new Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: <Widget>[
//                                         new Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: <Widget>[
//                                             new Text(
//                                               'เบอร์โทรศัพท์',
//                                               style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     )),
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               )
//             ],
//             ) : Center(child: CircularProgressIndicator());
//             }));
//   }
// }
