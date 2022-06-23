import 'dart:convert';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ihelpu_app/ipcon.dart';
import 'homepagedriver.dart';

class EditPassDriverPage extends StatefulWidget {
  final officer_id;

  EditPassDriverPage({
    this.officer_id,
  });

  @override
  _EditPassDriverPageState createState() => _EditPassDriverPageState();
}

class _EditPassDriverPageState extends State<EditPassDriverPage> {
  TextEditingController pass = TextEditingController();
  TextEditingController npass = TextEditingController();
  TextEditingController Confirmpass = TextEditingController();

  void edit() async {
    var url =
        Uri.parse("http://$ipcon/ihelpu/driverscreen/editpassworddriver.php");
    var response = await http.post(url, body: {
      "officer_id": widget.officer_id,
      "officer_password": pass.text,
      "newpassword": npass.text
    });

    print(widget.officer_id);
    print(pass.text);
    print(npass.text);

    var data = json.decode(response.body);

    if (data != "Error") {
      setState(() {
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.success,
                text: "เปลี่ยนรหัสผ่านสำเร็จ",
                onConfirm: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return HomepageDriver();
                  }));
                }));
      });
    } else {
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.warning,
              title: "เปลี่ยนรหัสผ่านไม่สำเร็จ",
              text: "โปรดตรวจสอบความถูกต้องของ \n รหัสผ่านของท่าน"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("รหัสผ่าน"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.arrow_turn_down_left,
            // color: Colors.black,
          ),
          onPressed: () {
            return Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.greenAccent[400],
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 20, bottom: 5),
                      child: Text(
                        'แก้ไขรหัสผ่าน',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 45, right: 45),
                      child: TextField(
                        controller: pass,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),
                            labelText: 'กรุณาใส่รหัสผ่านปัจจุบัน',
                            labelStyle:
                                TextStyle(fontSize: 14, color: Colors.grey)),
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 45, right: 45),
                      child: TextField(
                        controller: npass,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),
                            labelText: 'กรุณาใส่รหัสผ่านใหม่',
                            labelStyle:
                                TextStyle(fontSize: 14, color: Colors.grey)),
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 45, right: 45),
                      child: TextField(
                        controller: Confirmpass,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),
                            labelText: 'กรุณายืนยันรหัสผ่านใหม่',
                            labelStyle:
                                TextStyle(fontSize: 14, color: Colors.grey)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: RaisedButton(
                          color: Colors.greenAccent,
                          child: Text("ยืนยัน",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black)),
                          onPressed: () {
                            edit();
                          }),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }
}
