import 'dart:convert';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:ihelpu_app/ipcon.dart';
import 'package:ihelpu_app/mainmenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController();
  TextEditingController passWord = TextEditingController();

  Future login() async {
    var url = Uri.parse("http://$ipcon/ihelpu/login.php");//ค่าไอดีผู้ใช้
    var response = await http.post(url,
        body: {"user_username": userName.text, "user_password": passWord.text});//ให้แสดงชื่อและรหัสผ่านออกมา
    var data = json.decode(response.body);
    print(data);

    if (data != "Error") {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('user_username', data);
      setState(() {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return MainMenuPage();//ถ้าสามารถล็อคอินได้สำเร็จให้ส่งเข้าที่หน้าหลัก
        }));
      });
    } else {
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.warning,
            title: "ไม่สามารถเข้าสู่ระบบได้",
            text: "โปรดตรวจสอบความถูกต้องของ \n username และ password ของท่าน",
          ));//ตัวตรวจสอบความถูกต้องคอยวาลิเดดข้อมูลที่รับเข้ามา
    }
  }

  // void validate(){
  //   if(formKey.currentState!.validate()){
  //     print('validate');
  //   }else{
  //     print('Not validate');
  //   }
  // }

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
                    color: Colors.orange[600],
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
                      controller: userName,
                      autofocus: true,
                      validator: RequiredValidator(errorText: 'กรุณากรอกชื่อ '),
                      decoration: InputDecoration(
                        hintText: 'ชื่อผู้ใช้งาน',
                        prefixIcon: Icon(Icons.account_circle_rounded,
                            color: Colors.orange[600]),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      //keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: passWord,
                      obscureText: isHiddenPassword,
                      validator:
                          RequiredValidator(errorText: 'กรุณากรอกรหัสผ่าน '),
                      decoration: InputDecoration(
                        hintText: 'รหัสผ่าน',
                        prefixIcon: Icon(Icons.lock, color: Colors.orange[600]),
                        suffixIcon: IconButton(
                          icon:
                              Icon(Icons.visibility, color: Colors.orange[600]),
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
                      color: Colors.orange[600],
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          login();
                        }//วาลิเดตข้อมูลว่าค่าที่รับเข้ามาถูกต้องตามดาต้าเบสไหม
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
                      color: Colors.orange[600],
                      onPressed: () {
                        Navigator.of(context).pop();//ปุ่มย้อนกลับ
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
