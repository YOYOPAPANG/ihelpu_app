// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:ihelpu_app/DriverScreen/homepagedriver.dart';

class SuccessScreen extends StatefulWidget {
  SuccessScreen({Key? key}) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xff01b240),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "iHelpU",
              style: TextStyle(fontSize: 100, color: Colors.white),
            ),
            Text("เสร็จสิ้นภารกิจ",
                style: TextStyle(fontSize: 40, color: Colors.white)),
            Image.asset("assets/images/success_logo.png"),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                  textStyle:
                      MaterialStateProperty.all(TextStyle(fontSize: 22))),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return HomepageDriver();
                  }),
                  (route) => false,
                );
              },
              child: const Text('กลับสู่หน้าหลัก'),
            )
          ],
        ),
      ),
    );
  }
}
