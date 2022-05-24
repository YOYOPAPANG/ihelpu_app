import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:ihelpu_app/DriverScreen/formpagedriver.dart';

class SignUpDriver extends StatefulWidget {
  @override
  _SignUpDriverState createState() => _SignUpDriverState();
}

class _SignUpDriverState extends State<SignUpDriver> {
  GlobalKey<FormState> formKeydriver = GlobalKey<FormState>();
  TextEditingController dusername = TextEditingController();
  TextEditingController demail = TextEditingController();
  TextEditingController dpassword = TextEditingController();
  TextEditingController conFirmPassword = TextEditingController();

  void validate() {
    if (formKeydriver.currentState!.validate()) {
      print('validate');
    } else {
      print('Not validate');
    }
  }

  TextEditingController _controller = TextEditingController();

  bool isHiddenPassword = true;
  bool isHiddenconFirmPassword = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[275],
        body: Container(
          // padding: EdgeInsets.all(10),
          child: Form(
            key: formKeydriver,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: size.shortestSide - 200,
                    color: Colors.greenAccent[700],
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
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      TextFormField(
                        controller: dusername,
                        //autofocus: true,
                        validator:
                            RequiredValidator(errorText: 'กรุณากรอกชื่อ'),
                        decoration: InputDecoration(
                          hintText: 'ชื่อผู้ใช้งาน',
                          prefixIcon: Icon(Icons.account_circle_rounded,
                              color: Colors.greenAccent[700]),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: demail,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'กรุณากรอกอีเมลล์'),
                          EmailValidator(
                              errorText: 'กรุณากรอกอีเมลล์ที่ถูกต้อง')
                        ]),
                        decoration: InputDecoration(
                          hintText: 'อีเมลล์',
                          prefixIcon: Icon(Icons.email_outlined,
                              color: Colors.greenAccent[700]),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: dpassword,
                        obscureText: isHiddenPassword,
                        validator:
                            RequiredValidator(errorText: 'กรุณากรอกรหัสผ่าน'),
                        decoration: InputDecoration(
                          hintText: 'รหัสผ่าน',
                          prefixIcon:
                              Icon(Icons.lock, color: Colors.greenAccent[700]),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.visibility,
                                color: Colors.greenAccent[700]),
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
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: conFirmPassword,
                        obscureText: isHiddenconFirmPassword,
                        validator:
                            // RequiredValidator(errorText: 'กรุณากรอกยืนยันรหัสผ่าน'),
                            (value) {
                          if (value == dpassword.text) {
                            if (value == '') {
                              return 'กรุณากรอกยืนยันรหัสผ่าน';
                            } else {
                              return null;
                            }
                          } else {
                            return 'กรุณากรอกยืนยันรหัสผ่านให้ตรง';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'ยืนยันรหัสผ่าน',
                          prefixIcon:
                              Icon(Icons.lock, color: Colors.greenAccent[700]),
                          suffixIcon: InkWell(
                            child: IconButton(
                              icon: Icon(Icons.visibility,
                                  color: Colors.greenAccent[700]),
                              onPressed: () {
                                setState(() {
                                  if (isHiddenconFirmPassword == true) {
                                    isHiddenconFirmPassword = false;
                                  } else {
                                    isHiddenconFirmPassword = true;
                                  }
                                });
                              },
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    height: 55,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      color: Colors.greenAccent[700],
                      onPressed: () {
                        if (dpassword.text == conFirmPassword.text) {
                          validate();
                          if (formKeydriver.currentState!.validate()) {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return formpagedriver(
                                  dusername: dusername.text,
                                  demail: demail.text,
                                  dpassword: dpassword.text);
                            }));
                          }
                        } else {
                          validate();
                        }
                      },
                      child: Text(
                        'สมัคร',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    height: 55,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      color: Colors.greenAccent[700],
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
