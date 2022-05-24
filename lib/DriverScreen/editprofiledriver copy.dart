import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihelpu_app/DriverScreen/profiledriver.dart';
import 'package:ihelpu_app/ipcon.dart';
import 'package:http/http.dart' as http;

class EditProfileDriver extends StatefulWidget {
  final list;
  final i;
  EditProfileDriver({this.list , this.i});

  @override
  _EditProfileDriverState createState() => _EditProfileDriverState();
}

class _EditProfileDriverState extends State<EditProfileDriver> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController dfname = TextEditingController();
  TextEditingController organiname = TextEditingController();
  TextEditingController dtel = TextEditingController();
  TextEditingController demail = TextEditingController();

  void editprofile(){
    var url = Uri.parse("http://$ipcon/ihelpu/driverscreen/editprofiledriver.php");
    http.post(url , body: {
      'officer_id' : widget.list[widget.i]['officer_id'],
      "dfname": dfname.text,
      "organiname": organiname.text,
      "dtel": dtel.text,
      "demail" : demail.text
    });
  }
  
  void ProfileDriver() async {
      dfname = TextEditingController(text: widget.list[widget.i]['officer_fullname']);
      organiname = TextEditingController(text: widget.list[widget.i]['organi_name']);
      dtel = TextEditingController(text: widget.list[widget.i]['officer_tel']);
      demail = TextEditingController(text: widget.list[widget.i]['officer_email']);
  }

  @override
    void initState(){
      ProfileDriver();
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile Driver"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(CupertinoIcons.arrow_turn_down_left),
            onPressed: () {
              return Navigator.pop(context);
            },
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.greenAccent[400],
        ),
        body: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 50, bottom: 10),
                            child: Container(
                              height: 50,
                              child: TextFormField(
                                controller: dfname,
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
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 10, bottom: 10),
                            child: Container(
                              height: 50,
                              child: TextFormField(
                                controller: organiname,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'ชื่อหน่วยงาน',
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
                                controller: demail,
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
                                controller: dtel,
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
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        ProfileDriverPage()));
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