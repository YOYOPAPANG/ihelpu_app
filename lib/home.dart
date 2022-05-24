import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ihelpu_app/mainmenu.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.orange[600],
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 45, left: 0, right: 55),
                            child: Text(
                              'Success',
                              style:
                                  TextStyle(fontSize: 56, color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 0, left: 120, right: 20),
                            child: Text(
                              'ลงทะเบียนสำเร็จ',
                              style: TextStyle(
                                  fontSize: 21,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      CupertinoIcons.checkmark_circle_fill,
                      color: Colors.greenAccent[400],
                      size: 80.0,
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 45, right: 70 , top: 10),
                    child: Container(
                    height: 200,
                    width: 200,
                    child: Image.asset("assets/homemfoguete.png"),
                ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 140),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35)),
                  padding:
                      EdgeInsets.only(left: 45, right: 45, top: 5, bottom: 5),
                  child: Text(
                    'Welcome',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  color: Colors.greenAccent[700],
                  textColor: Colors.white,
                  splashColor: Colors.orange,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return MyHomePage();
                      }),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
