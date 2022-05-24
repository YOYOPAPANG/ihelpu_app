// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ihelpu_app/ipcon.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'homepagedriver.dart';

class EditProfileDriver extends StatefulWidget {
  final organi_name;
  final fullname;
  final email;
  final officer_tel;
  final officer_id;
  final officer_images;

  EditProfileDriver(
      {this.organi_name,
      this.fullname,
      this.email,
      this.officer_tel,
      this.officer_id,
      this.officer_images});

  @override
  _EditProfileDriverState createState() => _EditProfileDriverState();
}

class _EditProfileDriverState extends State<EditProfileDriver> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController organi_name = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController officer_tel = TextEditingController();
  TextEditingController email = TextEditingController();
  String _valueChanged = '';
  String _valueToValidate = '';

  File? _images;

  // void editprofile() {
  //   var url = Uri.parse("http://$ipcon/ihelpu/editprofile.php");
  //   http.post(url, body: {
  //     'user_id': widget.user_id,
  //     'user_fullname': fullname.text,
  //     'user_date': user_date.text,
  //     'user_weight': user_weight.text,
  //     'user_height': user_height.text,
  //     'user_allergy': user_allergy.text,
  //     'user_address': user_address.text,
  //     'user_tel': user_tel.text,
  //     'urelat_fname': urelat_fname.text,
  //     'relation': relation.text,
  //     'relation_tel': relation_tel.text,
  //     'user_email': email.text
  //   });
  // }

  void editprofile() async {
    print("1");
    if (_images != null) {
      print("2");
      final uri =
          Uri.parse("http://$ipcon/ihelpu/driverscreen/editprofiledriver.php");
      var request = http.MultipartRequest('POST', uri);
      var pic =
          await http.MultipartFile.fromPath("officer_images", _images!.path);
      request.files.add(pic);
      request.fields['officer_id'] = widget.officer_id;
      request.fields['dfname'] = fullname.text;
      request.fields['organiname'] = organi_name.text;
      request.fields['dtel'] = officer_tel.text;
      request.fields['demail'] = email.text;

      var response = await request.send();
      if (response.statusCode == 200) {
        print('Image Uploded');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomepageDriver()));
      } else {
        print('Image Not Uploded');
        print(response.statusCode);
      }
    } else {
      print("3");
      final uri =
          Uri.parse("http://$ipcon/ihelpu/driverscreen/editprofiledriver.php");
      var request = http.MultipartRequest('POST', uri);
      request.fields['officer_id'] = widget.officer_id;
      request.fields['dfname'] = fullname.text;
      request.fields['organiname'] = organi_name.text;
      request.fields['dtel'] = officer_tel.text;
      request.fields['demail'] = email.text;
      var response = await request.send();
      if (response.statusCode == 200) {
        print('xxxx');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomepageDriver()));
      } else {
        print('xxx');
        print(response.statusCode);
      }
    }
  }

  @override
  void initState() {
    jojo();
    print(widget.officer_images);
    print(widget.organi_name);

    print(widget.email);

    print(widget.officer_tel);

    print(widget.fullname);
    print(widget.officer_id);

    super.initState();
  }

  void Getimage(ImgSource source) async {
    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      cameraIcon: Icon(Icons.add),
    );
    setState(() {
      _images = File(image.path);
    });
  }

  List a = List.empty();
  String id = "";
  void jojo() async {
    fullname = TextEditingController(text: widget.fullname);
    officer_tel = TextEditingController(text: widget.officer_tel);
    email = TextEditingController(text: widget.email);
    organi_name = TextEditingController(text: widget.organi_name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Column(
                          children: <Widget>[
                            Container(
                              height: 250.0,
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 20.0, top: 20.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                      )),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: Stack(
                                        fit: StackFit.loose,
                                        children: <Widget>[
                                          _images == null
                                              ? Container(
                                                  width: 170,
                                                  height: 170,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: Colors.white),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          spreadRadius: 2,
                                                          blurRadius: 10,
                                                          color: Colors.black
                                                              .withOpacity(0.1))
                                                    ],
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          'http://$ipcon/ihelpu/upload/${widget.officer_images}'),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  child: CircleAvatar(
                                                    radius: 20,
                                                    backgroundImage:
                                                        FileImage(_images!),
                                                  ),
                                                  width: 170,
                                                  height: 170,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                ),
                                          Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 4,
                                                    ),
                                                    color: Colors.orange[600]),
                                                child: IconButton(
                                                  padding: EdgeInsets.all(0),
                                                  iconSize: 25,
                                                  icon: Icon(Icons.edit),
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    Getimage(ImgSource.Gallery);
                                                  },
                                                ),
                                              )),
                                        ]),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              color: Color(0xffFFFFFF),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 25.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "ข้อมูลส่วนตัว",
                                          style: TextStyle(fontSize: 24),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                  'ชื่อหน่วยงาน',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Flexible(
                                              child: TextField(
                                                controller: organi_name,
                                                decoration:
                                                    const InputDecoration(),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                  'ชื่อ - นามสกุล',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Flexible(
                                              child: TextField(
                                                controller: fullname,
                                                decoration:
                                                    const InputDecoration(),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                  'เบอร์โทรศัพท์',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: 10.0),
                                                child: TextField(
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  controller: officer_tel,
                                                  decoration:
                                                      const InputDecoration(),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                  'อีเมลล์',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Flexible(
                                              child: TextField(
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                controller: email,
                                                decoration:
                                                    const InputDecoration(),
                                              ),
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.only(top: 5, right: 5),
                                          height: 50,
                                          width: 150,
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            color: Colors.green, // background
                                            textColor:
                                                Colors.white, // foreground
                                            onPressed: () {
                                              setState(() {
                                                editprofile();

                                                // Navigator.of(context).push(
                                                //     MaterialPageRoute(
                                                //         builder: (context) {
                                                //   return MainMenuPage();
                                                // }));
                                                // ArtSweetAlert.show(
                                                //     context: context,
                                                //     artDialogArgs:
                                                //         ArtDialogArgs(
                                                //       type: ArtSweetAlertType
                                                //           .success,
                                                //       text: "แก้ไขข้อมูลสำเร็จ",
                                                //     ));
                                              });
                                            },
                                            child: Text('บันทึกข้อมูล'),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.only(top: 5, left: 5),
                                          height: 50,
                                          width: 150,
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            color: Colors.red, // background
                                            textColor:
                                                Colors.white, // foreground
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return HomepageDriver();
                                              }));
                                            },
                                            child: Text('ยกเลิก'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
