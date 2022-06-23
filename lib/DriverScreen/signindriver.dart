import 'dart:convert';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:ihelpu_app/DriverScreen/homepagedriver.dart';
import 'package:ihelpu_app/ipcon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInpageDriver extends StatefulWidget {
  @override
  _SignInpageDriverState createState() => _SignInpageDriverState();
}

class _SignInpageDriverState extends State<SignInpageDriver> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();//เป็นคีหลักที่ต้องเขียนนำมาใช้งานสำหรับ flutter 
  TextEditingController officer_username = TextEditingController();
  TextEditingController officer_password = TextEditingController();

  Future logindriver() async {
    var url = Uri.parse("http://$ipcon/ihelpu/driverscreen/logindriver.php");
    var response = await http.post(url, body: {
      "officer_username": officer_username.text,
      "officer_password": officer_password.text
    });
    var data = json.decode(response.body);
    print(data);//แสดงค่าออกมา

    if (data != "Error") {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('officer_username', data);
      setState(() {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return HomepageDriver();//ถ้าค่าที่ส่งเข้ามาถูกต้องให้เข้าไปหน้าล็อคอินเจ้าที่ได้
        }));
      });
    } else {
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.warning,
            title: "ไม่สามารถเข้าสู่ระบบได้",
            text: "โปรดตรวจสอบความถูกต้องของ \n username และ password ของท่าน",
          ));
    }
  }

  bool isHiddenPassword = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[275],
        body: Container(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: size.shortestSide - 200,
                    color: Colors.greenAccent[400],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // padding: const EdgeInsets.only(top: 60),
                          child: Text(
                            'ล็อคอิน',
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: officer_username,
                      autofocus: true,
                      validator: RequiredValidator(errorText: 'กรุณากรอกชื่อ '),
                      decoration: InputDecoration(
                        hintText: 'ชื่อผู้ใช้งาน',
                        prefixIcon: Icon(Icons.account_circle_rounded,
                            color: Colors.greenAccent[400]),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      //keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: officer_password,
                      obscureText: isHiddenPassword,
                      validator:
                          RequiredValidator(errorText: 'กรุณากรอกรหัสผ่าน '),
                      decoration: InputDecoration(
                        hintText: 'รหัสผ่าน',
                        prefixIcon:
                            Icon(Icons.lock, color: Colors.greenAccent[400]),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.visibility,
                              color: Colors.greenAccent[400]),
                          onPressed: () {
                            setState(() {
                              if (isHiddenPassword == true) {
                                isHiddenPassword = false;
                              } else {
                                isHiddenPassword = true;
                              }
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: 300,
                    height: 55,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      color: Colors.greenAccent[400],
                      onPressed: () {
                        if (formKey.currentState!.validate()) {//ตรวจสอบค่าที่รับมาถูกต้องไหม
                          logindriver();
                        }
                        // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                        // return HomepageDriver();
                        // }));
                      },
                      child: Text(
                        'ล็อคอิน',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: 300,
                    height: 55,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      color: Colors.greenAccent[400],
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'ย้อนกลับ',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
