import 'package:flutter/material.dart';
import 'package:ihelpu_app/DriverScreen/signupdriver.dart';
import 'package:ihelpu_app/signup.dart';

class SignUpPages extends StatefulWidget {
  @override
  _SignUpPagesState createState() => _SignUpPagesState();
}

class _SignUpPagesState extends State<SignUpPages> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
            body: Container(
                // padding: EdgeInsets.all(10),
                child: Column(children: [
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: size.shortestSide - 200,
          color: Colors.orange[600],
          child: Container(
            // padding: const EdgeInsets.only(top: 30),
            child: Text(
              'สมัครสมาชิก',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ]),
      SizedBox(height: 80),
      SizedBox(
        width: 320,
        height: 60,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.orange[600],
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) {
                return SignUpPage();
              }),
            );
          },
          child: Text(
            'ลงทะเบียนสำหรับผู้ใช้งาน',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      SizedBox(height: 30),
      SizedBox(
        width: 320,
        height: 60,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.orange[600],
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) {
                return SignUpDriver();
              }),
            );
          },
          child: Text(
            'ลงทะเบียนสำหรับกู้ภัย',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      SizedBox(
        height: 80,
      ),
      SizedBox(
        width: 250,
        height: 60,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.orange[600],
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'ย้อนกลับ',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      )
    ]))));
  }
}
