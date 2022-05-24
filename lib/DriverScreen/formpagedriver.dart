import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:ihelpu_app/DriverScreen/signindriver.dart';
import 'package:ihelpu_app/ipcon.dart';
import 'package:http/http.dart' as http;
import 'package:form_field_validator/form_field_validator.dart';

class formpagedriver extends StatefulWidget {
  String dusername;
  String demail;
  String dpassword;

  formpagedriver(
      {required this.dusername, required this.demail, required this.dpassword});

  @override
  _formpagedriverState createState() => _formpagedriverState();
}

class _formpagedriverState extends State<formpagedriver> {
  GlobalKey<FormState> formKeyd = GlobalKey<FormState>();
  TextEditingController dfname = TextEditingController();
  TextEditingController dtel = TextEditingController();
  TextEditingController dorganiname = TextEditingController();

  Future registerdriver() async {
    final uri =
        Uri.parse("http://$ipcon/ihelpu/driverscreen/registerdriver.php");
    var request = http.MultipartRequest('POST', uri);

    request.fields['officer_fullname'] = dfname.text;
    request.fields['officer_tel'] = dtel.text;
    request.fields['organi_name'] = dorganiname.text;
    request.fields['officer_username'] = widget.dusername;
    request.fields['officer_password'] = widget.dpassword;
    request.fields['officer_email'] = widget.demail;

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Register Success');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInpageDriver()));
    } else {
      print('Register Failed');
    }
    setState(() {});
  }

  void validate() {
    if (formKeyd.currentState!.validate()) {
      print('validate');
    } else {
      print('Not validate');
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Form(
              key: formKeyd,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    // alignment: Alignment.topLeft,
                    width: double.infinity,
                    height: size.shortestSide - 290,
                    color: Colors.greenAccent[400],
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 25, left: 35),
                            child: Text(
                              'สมัครสมาชิก',
                              style:
                                  TextStyle(fontSize: 56, color: Colors.white),
                            ),
                          ),
                        ),
                        // Container(
                        //   alignment: Alignment.topLeft,
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(top: 0, left: 150),
                        //     child: Text(
                        //       'ลงทะเบียนผู้ใช้งาน',
                        //       style: TextStyle(
                        //           fontSize: 20,
                        //           color: Colors.white,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 30, 20.0, 10.0),
                    child: TextFormField(
                      controller: dfname,
                      validator: RequiredValidator(
                          errorText: 'กรุณากรอก ชื่อ-นามสกุล'),
                      decoration: InputDecoration(
                        labelText: "ชื่อ-นามสกุล *",
                        // hintText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: TextFormField(
                      controller: dorganiname,
                      validator: RequiredValidator(
                          errorText: 'กรุณากรอก ชื่อหน่วยงาน'),
                      decoration: InputDecoration(
                        labelText: "ชื่อหน่วยงาน *",
                        // hintText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: dtel,
                      validator: RequiredValidator(
                          errorText: 'กรุณากรอก เบอร์โทรติดต่อ'),
                      decoration: InputDecoration(
                        labelText: "เบอร์โทรติดต่อ *",
                        // hintText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  // SizedBox(height: height*0.275,),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    width: double.infinity,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35)),
                        color: Colors.greenAccent[700],
                        splashColor: Colors.orange,
                        child: Text(
                          "ยืนยัน",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          if (formKeyd.currentState!.validate()) {
                            registerdriver();
                          } else {
                            validate();
                          }
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
