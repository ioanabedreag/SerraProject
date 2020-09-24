import 'dart:convert';

import 'package:qrscan/qrscan.dart' as scanner;

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'api_url.dart';
import 'home_page.dart';

class WorkerPage extends StatefulWidget {
  WorkerPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WorkerPageState createState() => _WorkerPageState();
}

class _WorkerPageState extends State<WorkerPage> {
  String cameraScanResult = "";
  String qrCode;

  String usernameWorker = "";
  String usernameUser = "";
  String quantity = "";

  @override
  void initState() {
    super.initState();
  }

  Future<List<String>> postData() async {
    int index = 0;
    usernameWorker = '';
    usernameUser = '';
    while (qrCode[index] != '-') {
      usernameWorker += qrCode[index];
      index++;
    }
    index++;
    print(usernameWorker);
    while (index < qrCode.length) {
      usernameUser += qrCode[index];
      index++;
    }
    print(usernameUser);

    var body = jsonEncode({
      "UsernameWorker": usernameWorker,
      "UsernameUser": usernameUser,
      "Quantity": quantity,
    });

    var result = await http.post(
      ApiUrl.addUserUrl,
      body: body,
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );

    if (result.statusCode == 200) {
      // showPostSnackBar();
      print("ok");
    } else {
      // showErrorSnackBar();
      print("not ok");
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[200],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              textAlign: TextAlign.center,
              controller: TextEditingController()..text = qrCode,
              onChanged: (value) {
                qrCode = value;
              },
              decoration: InputDecoration(hintText: "QR Code"),
            ),
            TextField(
              textAlign: TextAlign.center,
              controller: TextEditingController()..text = quantity,
              onChanged: (value) {
                quantity = value;
              },
              decoration: InputDecoration(hintText: "Quantity"),
            ),
            RaisedButton(
              elevation: 90,
              color: Colors.white,
              textColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              onPressed: () {
                postData();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(title: "Home")));
              },
              child: Text("Done"),
            )
          ],
        ),
      ),
    );
  }
}
