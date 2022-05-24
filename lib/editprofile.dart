import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihelpu_app/ipcon.dart';
import 'package:http/http.dart' as http;
import 'package:ihelpu_app/profile.dart';

class EditProfile extends StatefulWidget {
  final list;
  final i;
  EditProfile({this.list, this.i});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController ufname = TextEditingController();
  TextEditingController udate = TextEditingController();
  TextEditingController uweight = TextEditingController();
  TextEditingController uheight = TextEditingController();
  TextEditingController uallergy = TextEditingController();
  TextEditingController uaddress = TextEditingController();
  TextEditingController utel = TextEditingController();
  TextEditingController urelat_fname = TextEditingController();
  TextEditingController relation = TextEditingController();
  TextEditingController relation_tel = TextEditingController();
  TextEditingController uemail = TextEditingController();

  String _valueChanged = '';
  String _valueToValidate = '';

  void editprofile() {
    var url = Uri.parse("http://$ipcon/ihelpu/editprofile.php");
    http.post(url, body: {
      'user_id': widget.list[widget.i]['user_id'],
      'user_fullname': ufname.text,
      'user_date': udate.text,
      'user_weight': uweight.text,
      'user_height': uheight.text,
      'user_allergy': uallergy.text,
      'user_address': uaddress.text,
      'user_tel': utel.text,
      'urelat_fname': urelat_fname.text,
      'relation': relation.text,
      'relation_tel': relation_tel.text,
      'user_email': uemail.text
    });
  }

  void Profile() async {
    ufname =
        TextEditingController(text: widget.list[widget.i]['user_fullname']);
    udate = TextEditingController(text: widget.list[widget.i]['user_date']);
    uweight = TextEditingController(text: widget.list[widget.i]['user_weight']);
    uheight = TextEditingController(text: widget.list[widget.i]['user_height']);
    uallergy =
        TextEditingController(text: widget.list[widget.i]['user_allergy']);
    uaddress =
        TextEditingController(text: widget.list[widget.i]['user_address']);
    utel = TextEditingController(text: widget.list[widget.i]['user_tel']);
    urelat_fname =
        TextEditingController(text: widget.list[widget.i]['urelat_fname']);
    relation = TextEditingController(text: widget.list[widget.i]['relation']);
    relation_tel =
        TextEditingController(text: widget.list[widget.i]['relation_tel']);
    uemail = TextEditingController(text: widget.list[widget.i]['user_email']);
  }

  @override
  void initState() {
    Profile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(CupertinoIcons.arrow_turn_down_left),
            onPressed: () {
              return Navigator.pop(context);
            },
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.orange[600],
        ),
        body: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 50, bottom: 10),
                            child: Container(
                              height: 0,
                              child: TextFormField(
                                controller: ufname,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'ชื่อนามสกุล',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
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
                              icon:
                                  Icon(Icons.event, color: Colors.orange[600]),
                              calendarTitle: 'เลือกวันเดือนปีเกิด',
                              dateLabelText: 'วัน/เดือน/ปีเกิด *',
                              onChanged: (val) =>
                                  setState(() => _valueChanged = val),
                              validator: (val) {
                                setState(() => _valueToValidate = val ?? '');
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 10, bottom: 10),
                            child: Container(
                              height: 50,
                              child: TextFormField(
                                controller: uemail,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'อีเมล',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 10, bottom: 10),
                            child: Container(
                              height: 50,
                              child: TextFormField(
                                controller: utel,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'เบอร์โทรศัพท์',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 10, bottom: 10),
                            child: Container(
                              height: 50,
                              child: TextFormField(
                                controller: uweight,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'น้ำหนัก',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 10, bottom: 10),
                            child: Container(
                              height: 50,
                              child: TextFormField(
                                controller: uheight,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'ส่วนสูง',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 10, bottom: 10),
                            child: Container(
                              height: 50,
                              child: TextFormField(
                                controller: uallergy,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'การแพ้ยา',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 10, bottom: 10),
                            child: Container(
                              height: 50,
                              child: TextFormField(
                                controller: uaddress,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'ที่อยู่',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 12, top: 10, bottom: 5),
                            child: Text('ข้อมูลญาติ',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 10, bottom: 10),
                            child: Container(
                              height: 50,
                              child: TextFormField(
                                controller: urelat_fname,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'ชื่อนามสกุล ญาติ',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 10, bottom: 10),
                            child: Container(
                              height: 50,
                              child: TextFormField(
                                controller: relation,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'ความสัมพันธ์',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 10, bottom: 10),
                            child: Container(
                              height: 50,
                              child: TextFormField(
                                controller: relation_tel,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'เบอร์โทรศัพท์',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  padding: EdgeInsets.only(top: 5),
                                  height: 50,
                                  width: 150,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    color: Colors.green, // background
                                    textColor: Colors.white, // foreground
                                    onPressed: () {
                                      setState(() {
                                        editprofile();
                                        Navigator.of(context).pop();
                                      });
                                    },
                                    child: Text('Submit'),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 5),
                                height: 50,
                                width: 150,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  color: Colors.red, // background
                                  textColor: Colors.white, // foreground
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel'),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
