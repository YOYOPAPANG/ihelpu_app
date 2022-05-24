// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:projectihelpu/DriverScreen/editpassdriver.dart';
// import 'package:projectihelpu/DriverScreen/editprofiledriver.dart';
// import 'package:projectihelpu/ipcon.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ProfileDriverPage extends StatefulWidget {

//   @override
//   _ProfileDriverPageState createState() => _ProfileDriverPageState();
// }

// class _ProfileDriverPageState extends State<ProfileDriverPage> {

//   String officer_username = "";

//   Future getUserid() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     setState(() {
//       officer_username = preferences.getString('officer_username')!;
//     });
//   }

//   Future<List> getofficerFullname() async {
//     final response = await http.get(
//         Uri.parse("http://$ipcon/ihelpu/driverscreen/getofficerid.php?officer_id=${officer_username}"));
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
//     return SafeArea(
//       child: Scaffold(
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
//           backgroundColor: Colors.greenAccent[400],
//         ),
//         body: FutureBuilder<List>(
//           future: getofficerFullname(),
//           builder: (context, data) {
//             return data.hasData ? ListView(
//               children: [
//                 Column(mainAxisAlignment: MainAxisAlignment.start, children: [
//                   Center(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 50),
//                         Accountdetail(
//                           prefixtext: 'ชื่อหน่วยงาน:',
//                           text: data.data![0]['organi_name'],
//                         ),
//                         Accountdetail(
//                           prefixtext: 'ชื่อนามสกุล:',
//                           text: data.data![0]['officer_fullname'],
//                         ),
//                         Accountdetail(
//                           prefixtext: 'เบอร์โทรศัพท์:',
//                           text: data.data![0]['officer_tel'],
//                         ),
//                         Accountdetail(
//                           prefixtext: 'อีเมล:',
//                           text: data.data![0]['officer_email'],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 35, vertical: 5),
//                           child: FlatButton(
//                             padding: EdgeInsets.all(15),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15)),
//                             color: Colors.white,
//                             onPressed: () {
//                               Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (BuildContext context) {
//                                 return EditProfileDriver(list: data.data,i: 0);
//                               }));
//                             },
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   Icons.vpn_key,
//                                   color: Colors.black,
//                                 ),
//                                 SizedBox(width: 20),
//                                 Expanded(
//                                   child: Text(
//                                     'แก้ไขข้อมูล',
//                                     style: Theme.of(context).textTheme.bodyText1,
//                                   ),
//                                 ),
//                                 // Icon(Icons.arrow_forward_ios)
//                               ],
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 35, vertical: 5),
//                           child: FlatButton(
//                             padding: EdgeInsets.all(15),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15)),
//                             color: Colors.white,
//                             onPressed: () {
//                               Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (BuildContext context) {
//                                 return EditPassDriverPage(list: data.data);
//                               }));
//                             },
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   Icons.vpn_key,
//                                   color: Colors.black,
//                                 ),
//                                 SizedBox(width: 20),
//                                 Expanded(
//                                   child: Text(
//                                     'เปลี่ยนรหัสผ่าน',
//                                     style: Theme.of(context).textTheme.bodyText1,
//                                   ),
//                                 ),
//                                 // Icon(Icons.arrow_forward_ios)
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ]),
//               ],
//             ) : Center(child: CircularProgressIndicator());
//           }
//         ),
//       ),
//     );
//   }
// }

// class Accountdetail extends StatelessWidget {
//   const Accountdetail({Key? key, required this.text, required this.prefixtext})
//       : super(key: key);

//   final String text;
//   final String prefixtext;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
//       child: Row(
//         children: [
//           Text(
//             prefixtext,
//             style: Theme.of(context).textTheme.bodyText1,
//           ),
//           SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               text,
//               style: Theme.of(context).textTheme.bodyText1,
//             ),
//           ),
//           // Icon(Icons.arrow_forward_ios)
//         ],
//       ),
//     );
//   }
// }
