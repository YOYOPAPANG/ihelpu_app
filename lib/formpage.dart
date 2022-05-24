import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:ihelpu_app/home.dart';
import 'package:ihelpu_app/ipcon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Formdate extends StatefulWidget {
  String uusername;
  String uemail;
  String upassword;

  Formdate(
      {required this.uusername, required this.uemail, required this.upassword});

  @override
  _FormdateState createState() => _FormdateState();
}

class _FormdateState extends State<Formdate> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FormPage(
          uusername: widget.uusername,
          uemail: widget.uemail,
          upassword: widget.upassword),
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('th', 'TH'),
      supportedLocales: [
        // const Locale('en', 'US'), // English
        const Locale('th', 'TH'), // Thai
      ],
    );
  }
}

class FormPage extends StatefulWidget {
  String uusername;
  String uemail;
  String upassword;

  FormPage(
      {required this.uusername, required this.uemail, required this.upassword});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String selectedChoice = '';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController ufname = TextEditingController();
  TextEditingController udate = TextEditingController();
  // TextEditingController usex = TextEditingController();
  TextEditingController uweight = TextEditingController();
  TextEditingController uheight = TextEditingController();
  TextEditingController uallergy = TextEditingController();
  TextEditingController uaddress = TextEditingController();
  TextEditingController utel = TextEditingController();
  TextEditingController urelat_fname = TextEditingController();
  TextEditingController relation = TextEditingController();
  TextEditingController relation_tel = TextEditingController();

  String _valueChanged = '';
  String _valueToValidate = '';

  void validate() {
    if (formKey.currentState!.validate()) {
      print('validate');
    } else {
      print('Not validate');
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   // Intl.defaultLocale = 'pt_BR';
  //   //_initialValue = DateTime.now().toString();
  //   udate = TextEditingController(text: DateTime.now().toString());
  // }

  Future register() async {
    final uri = Uri.parse("http://$ipcon/ihelpu/register.php");
    var request = http.MultipartRequest('POST', uri);

    request.fields['user_fullname'] = ufname.text;
    request.fields['user_sex'] = selectedChoice;
    request.fields['user_date'] = udate.text;
    request.fields['user_weight'] = uweight.text;
    request.fields['user_height'] = uheight.text;
    request.fields['user_allergy'] = uallergy.text;
    request.fields['user_address'] = uaddress.text;
    request.fields['user_tel'] = utel.text;
    request.fields['urelat_fname'] = urelat_fname.text;
    request.fields['relation'] = relation.text;
    request.fields['relation_tel'] = relation_tel.text;
    request.fields['user_username'] = widget.uusername;
    request.fields['user_password'] = widget.upassword;
    request.fields['user_email'] = widget.uemail;

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Register Success');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      print('Register Failed');
    }
    setState(() {});
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
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: size.shortestSide - 290,
                    color: Colors.orange[600],
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
                      controller: ufname,
                      validator: RequiredValidator(
                          errorText: 'กรุณากรอก ชื่อ-นามสกุล'),
                      decoration: InputDecoration(
                        labelText: "ชื่อ-นามสกุล *",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          'เพศ',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xffacacac)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Radio(
                            value: "ชาย",
                            groupValue: selectedChoice,
                            onChanged: (onChanged) {
                              setState(() {
                                selectedChoice = "ชาย";
                              });
                            }),
                        Text(
                          'ชาย',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xffacacac)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Radio(
                            value: "หญิง",
                            groupValue: selectedChoice,
                            onChanged: (onChanged) {
                              setState(() {
                                setState(() {
                                  selectedChoice = "หญิง";
                                });
                              });
                            }),
                        Text(
                          'หญิง',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xffacacac)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 25, 10),
                    child: DateTimePicker(
                      type: DateTimePickerType.date,
                      dateMask: 'dd/MM/yyyy',
                      controller: udate,
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2100),
                      icon: Icon(Icons.event, color: Colors.orange[600]),
                      calendarTitle: 'เลือกวันเดือนปีเกิด',
                      dateLabelText: 'วัน/เดือน/ปีเกิด *',
                      onChanged: (val) => setState(() => _valueChanged = val),
                      validator: (val) {
                        setState(() => _valueToValidate = val ?? '');
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: uweight,
                      validator:
                          RequiredValidator(errorText: 'กรุณากรอก น้ำหนัก'),
                      decoration: InputDecoration(
                        labelText: "น้ำหนัก *",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: uheight,
                      validator:
                          RequiredValidator(errorText: 'กรุณากรอก ส่วนสูง'),
                      decoration: InputDecoration(
                        labelText: "ส่วนสูง *",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: TextFormField(
                      controller: uallergy,
                      decoration: InputDecoration(
                        labelText: "แพ้ยา",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: TextFormField(
                      controller: uaddress,
                      validator:
                          RequiredValidator(errorText: 'กรุณากรอก ที่อยู่'),
                      decoration: InputDecoration(
                        labelText: "ที่อยู่ *",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: utel,
                      validator: RequiredValidator(
                          errorText: 'กรุณากรอก เบอร์โทรติดต่อ'),
                      decoration: InputDecoration(
                        labelText: "เบอร์โทรติดต่อ *",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 20, bottom: 20),
                    child: Text(
                      'ญาติผู้ใช้งาน',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: TextFormField(
                      controller: urelat_fname,
                      validator: RequiredValidator(
                          errorText: 'กรุณากรอก ชื่อ-นามสกุล'),
                      decoration: InputDecoration(
                        labelText: "ชื่อ-นามสกุล *",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: TextFormField(
                      controller: relation,
                      validator: RequiredValidator(
                          errorText: 'กรุณากรอก ความสัมพันธ์'),
                      decoration: InputDecoration(
                        labelText: "ความสัมพันธ์ *",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: relation_tel,
                      validator: RequiredValidator(
                          errorText: 'กรุณากรอก เบอร์โทรติดต่อญาติ'),
                      decoration: InputDecoration(
                        labelText: "เบอร์โทรติดต่อญาติ *",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
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
                          if (formKey.currentState!.validate()) {
                            register();
                          } else {
                            validate();
                          }
                        }),
                  ),
                  SizedBox(height: 30)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
