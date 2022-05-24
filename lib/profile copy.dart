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
//           backgroundColor: Colors.orange[600],
//         ),
//         body: FutureBuilder<List>(
//           future: getFullname(),
//           builder: (context, data) {
//             DateTime datetimeformat = DateFormat('yyyy-MM-dd').parse(data.data![0]['user_date']);
//             return data.hasData ? ListView(
//               children: [
//                 Column(mainAxisAlignment: MainAxisAlignment.start, children: [
//                   Center(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 20),
//                         Accountdetail(
//                           prefixtext: 'ชื่อนามสกุล:',
//                           text: data.data![0]['user_fullname'],
//                         ),
//                         Accountdetail(
//                           prefixtext: 'วันเดือนปีเกิด:',
//                           text: DateFormat('dd-MM-yyyy').format(datetimeformat) //data.data![0]['user_date']
//                         ),
//                         Accountdetail(
//                           prefixtext: 'อีเมล:',
//                           text: data.data![0]['user_email'],
//                         ),
//                         Accountdetail(
//                           prefixtext: 'เบอร์โทรศัพท์:',
//                           text: data.data![0]['user_tel'],
//                         ),
//                         Accountdetail(
//                           prefixtext: 'น้ำหนัก:',
//                           text: data.data![0]['user_weight'],
//                         ),
//                         Accountdetail(
//                           prefixtext: 'ส่วนสูง:',
//                           text: data.data![0]['user_height'],
//                         ),
//                         Accountdetail(
//                           prefixtext: 'การแพ้ยา',
//                           text: data.data![0]['user_allergy'],
//                         ),
//                         Accountdetail(
//                           prefixtext: 'ที่อยู่:',
//                           text: data.data![0]['user_address'],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 12,top: 10,bottom: 5),
//                           child: Text('ข้อมูลญาติ',style: TextStyle(fontSize: 18, color: Colors.black)),
//                         ),
//                         Accountdetail(
//                           prefixtext: 'ชื่อนามสกุล ญาติ:',
//                           text: data.data![0]['urelat_fname'],
//                         ),
//                         Accountdetail(
//                           prefixtext: 'ความสัมพันธ์:',
//                           text: data.data![0]['relation'],
//                         ),
//                         Accountdetail(
//                           prefixtext: 'เบอร์โทรศัพท์:',
//                           text: data.data![0]['relation_tel'],
//                         ),
//                         Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 35, vertical: 5),
//                               child: FlatButton(
//                                 padding: EdgeInsets.all(15),
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(15)),
//                                 color: Colors.white,
//                                 onPressed: () {
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                       builder: (BuildContext context) {
//                                     return EditProfile(list: data.data,i: 0);
//                                   }));
//                                 },
//                                 child: Row(
//                                   children: [
//                                     Icon(
//                                       Icons.vpn_key,
//                                       color: Colors.black,
//                                     ),
//                                     SizedBox(width: 20),
//                                     Expanded(
//                                       child: Text(
//                                         'แก้ไขข้อมูล',
//                                         style: Theme.of(context).textTheme.bodyText1,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
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
//                                 return EditPassPage(list: data.data);
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
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 15)
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
//           SizedBox(width: 20),
//           Expanded(
//             child: Text(
//               text,
//               style: Theme.of(context).textTheme.bodyText1,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

