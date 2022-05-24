import 'dart:convert';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ihelpu_app/ipcon.dart';
import 'mainmenu.dart';

class EditPassPage extends StatefulWidget {
  final user_id;

  EditPassPage({
    this.user_id,
  });

  @override
  _EditPassPageState createState() => _EditPassPageState();
}

class _EditPassPageState extends State<EditPassPage> {
  TextEditingController pass = TextEditingController();
  TextEditingController npass = TextEditingController();
  TextEditingController Confirmpass = TextEditingController();

  void edit() async {
    var url = Uri.parse("http://$ipcon/ihelpu/editpassword.php");
    var response = await http.post(url, body: {
      "user_id": widget.user_id,
      "user_password": pass.text,
      "newpassword": npass.text
    });

    print(widget.user_id);
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
                    return MainMenuPage();
                  }));
                }));
      });
    } else {
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.warning,
              title: "เปลี่ยนรหัสผ่านไม่สำเร็จ",
              text: "โปรดตรวจสอบความถูกต้องของ \n password ของท่าน"));
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
          ),
          onPressed: () {
            return Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange[600],
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
                            labelText: 'กรุณาใส่รหัสผ่านปัจจุบัน',
                            labelStyle: TextStyle(fontSize: 14)),
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
                            labelText: 'กรุณาใส่รหัสผ่านใหม่',
                            labelStyle: TextStyle(fontSize: 14)),
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
                            labelText: 'กรุณายืนยันรหัสผ่านใหม่',
                            labelStyle: TextStyle(fontSize: 14)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: RaisedButton(
                          color: Colors.green,
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
