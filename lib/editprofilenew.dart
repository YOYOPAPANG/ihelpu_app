import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ihelpu_app/ipcon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainmenu.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';

class EditProfilenew extends StatefulWidget {
  final user_id;
  final fullname;
  final user_date;
  final email;
  final user_tel;
  final user_weight;
  final user_height;
  final user_allergy;
  final user_address;
  final urelat_fname;
  final relation;
  final relation_tel;
  final user_images;

  EditProfilenew(
      {this.user_id,
      this.fullname,
      this.user_date,
      this.email,
      this.user_tel,
      this.user_weight,
      this.user_height,
      this.user_allergy,
      this.user_address,
      this.urelat_fname,
      this.relation,
      this.relation_tel,
      this.user_images});

  @override
  _EditProfilenewState createState() => _EditProfilenewState();
}

class _EditProfilenewState extends State<EditProfilenew> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController fullname = TextEditingController();
  TextEditingController user_date = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController user_tel = TextEditingController();
  TextEditingController user_weight = TextEditingController();
  TextEditingController user_height = TextEditingController();
  TextEditingController user_allergy = TextEditingController();
  TextEditingController user_address = TextEditingController();
  TextEditingController urelat_fname = TextEditingController();
  TextEditingController relation = TextEditingController();
  TextEditingController relation_tel = TextEditingController();
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
      final uri = Uri.parse("http://$ipcon/ihelpu/editprofile.php");
      var request = http.MultipartRequest('POST', uri);
      var pic = await http.MultipartFile.fromPath("user_images", _images!.path);
      request.files.add(pic);
      request.fields['user_id'] = widget.user_id;
      request.fields['user_fullname'] = fullname.text;
      request.fields['user_date'] = user_date.text;
      request.fields['user_weight'] = user_weight.text;
      request.fields['user_height'] = user_height.text;
      request.fields['user_allergy'] = user_allergy.text;
      request.fields['user_address'] = user_address.text;
      request.fields['user_tel'] = user_tel.text;
      request.fields['urelat_fname'] = urelat_fname.text;
      request.fields['relation'] = relation.text;
      request.fields['relation_tel'] = relation_tel.text;
      request.fields['user_email'] = email.text;

      var response = await request.send();
      if (response.statusCode == 200) {//แสดงค่าว่าโอเค
        print('Image Uploded');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainMenuPage()));
      } else {
        print('Image Not Uploded');
        print(response.statusCode);
      }
    } else {
      print("3");
      final uri = Uri.parse("http://$ipcon/ihelpu/editprofile.php");
      var request = http.MultipartRequest('POST', uri);
      request.fields['user_id'] = widget.user_id;
      request.fields['user_fullname'] = fullname.text;
      request.fields['user_date'] = user_date.text;
      request.fields['user_weight'] = user_weight.text;
      request.fields['user_height'] = user_height.text;
      request.fields['user_allergy'] = user_allergy.text;
      request.fields['user_address'] = user_address.text;
      request.fields['user_tel'] = user_tel.text;
      request.fields['urelat_fname'] = urelat_fname.text;
      request.fields['relation'] = relation.text;
      request.fields['relation_tel'] = relation_tel.text;
      request.fields['user_email'] = email.text;
      var response = await request.send();
      if (response.statusCode == 200) {
        print('suscess');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainMenuPage()));
      } else {
        print('not suscess');
        print(response.statusCode);
      }
    }
  }

  @override
  void initState() {
    jojo();

    super.initState();
  }

  void Getimage(ImgSource source) async {
    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      cameraIcon: const Icon(Icons.add),
    );
    setState(() {
      _images = File(image.path);
    });
  }

  List a = List.empty();
  String id = "";
  void jojo() async {
    fullname = TextEditingController(text: widget.fullname);
    user_date = TextEditingController(text: widget.user_date);
    email = TextEditingController(text: widget.email);
    user_tel = TextEditingController(text: widget.user_tel);
    user_weight = TextEditingController(text: widget.user_weight);
    user_height = TextEditingController(text: widget.user_height);
    user_allergy = TextEditingController(text: widget.user_allergy);
    user_address = TextEditingController(text: widget.user_address);
    urelat_fname = TextEditingController(text: widget.urelat_fname);
    relation = TextEditingController(text: widget.relation);
    relation_tel = TextEditingController(text: widget.relation_tel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("แก้ไขโปรไฟล์ "),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.arrow_turn_down_left),
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
                        Column(
                          children: <Widget>[
                            Container(
                              height: 250.0,
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, top: 20.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
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
                                                          'http://$ipcon/ihelpu/upload/${widget.user_images}'),
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
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  iconSize: 25,
                                                  icon: const Icon(Icons.edit),
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
                              color: const Color(0xffFFFFFF),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 25.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(top: 25.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            const Text(
                                              'ข้อมูลส่วนตัว',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[],
                                            )
                                          ],
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: const <Widget>[
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
                                        padding: const EdgeInsets.only(
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
                                      padding: const EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: DateTimePicker(
                                        type: DateTimePickerType.date,
                                        dateMask: 'dd/MM/yyyy',
                                        controller: user_date,
                                        firstDate: DateTime(1950),
                                        lastDate: DateTime(2100),
                                        calendarTitle: 'เลือกวันเดือนปีเกิด',
                                        dateLabelText: 'วัน/เดือน/ปีเกิด *',
                                        onChanged: (val) =>
                                            setState(() => _valueChanged = val),
                                        validator: (val) {
                                          setState(() =>
                                              _valueToValidate = val ?? '');
                                          return null;
                                        },
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: const <Widget>[
                                                Text(
                                                  'อีเมลล์ ',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                /*TextFormField(
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                )*/
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.only(
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
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                const Text(
                                                  'เบอร์โทรศัพท์ ',
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
                                        padding: const EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0),
                                                child: TextField(
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  controller: user_tel,
                                                  decoration:
                                                      const InputDecoration(),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                const Text(
                                                  'น้ำหนัก',
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
                                        padding: const EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Flexible(
                                              child: TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: user_weight,
                                                decoration:
                                                    const InputDecoration(),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                const Text(
                                                  'ส่วนสูง',
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
                                        padding: const EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Flexible(
                                              child: TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: user_height,
                                                decoration:
                                                    const InputDecoration(),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                const Text(
                                                  'การแพ้ยา',
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
                                        padding: const EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Flexible(
                                              child: TextField(
                                                controller: user_allergy,
                                                decoration:
                                                    const InputDecoration(),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                const Text(
                                                  'ที่อยู่',
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
                                        padding: const EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Flexible(
                                              child: TextField(
                                                controller: user_address,
                                                decoration:
                                                    const InputDecoration(),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(top: 30.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            const Text(
                                              'ข้อมูลญาติ',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[],
                                            )
                                          ],
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                const Text(
                                                  'ชื่อ - นามสกุลญาติ',
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
                                        padding: const EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Flexible(
                                              child: TextField(
                                                controller: urelat_fname,
                                                decoration:
                                                    const InputDecoration(),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: const <Widget>[
                                                Text(
                                                  'ความสัมพันธ์ ',
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
                                        padding: const EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Flexible(
                                              child: TextField(
                                                controller: relation,
                                                decoration:
                                                    const InputDecoration(),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: const <Widget>[
                                                Text(
                                                  'เบอร์โทรศัพท์ ',
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
                                        padding: const EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Flexible(
                                              child: TextField(
                                                keyboardType:
                                                    TextInputType.phone,
                                                controller: relation_tel,
                                                decoration:
                                                    const InputDecoration(),
                                              ),
                                            ),
                                          ],
                                        )),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                              top: 5, right: 5),
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
                                            child: const Text('บันทึกข้อมูล'),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 5),
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
                                                return MainMenuPage();
                                              }));
                                            },
                                            child: const Text('ยกเลิก'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
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
