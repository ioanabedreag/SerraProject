import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_farm/api_url.dart';
import 'package:flutter_farm/home_page.dart';

class WorkerPage extends StatefulWidget {
  WorkerPage({Key key, this.title, @required this.qrCode}) : super(key: key);

  final String title;
  final String qrCode;

  @override
  _WorkerPageState createState() => _WorkerPageState();
}

class _WorkerPageState extends State<WorkerPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String workerName = "";
  String username = "";
  String quantity = "";

  @override
  void initState() {
    int index = 0;
    var workerNameVar = '';
    var usernameVar = '';
    while (widget.qrCode[index] != '-') {
      workerNameVar += widget.qrCode[index];
      index++;
    }
    index++;
    while (index < widget.qrCode.length) {
      usernameVar += widget.qrCode[index];
      index++;
    }
    setState(() {
      workerName = workerNameVar;
      username = usernameVar;
    });
    super.initState();
  }

  Future<List<String>> postData() async {
    var body = jsonEncode({
      "WorkerName": workerName,
      "Username": username,
      "Quantity": quantity,
    });

    var result = await http.post(
      ApiUrl.addHarvestQunatityUrl,
      body: body,
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );

    if (result.statusCode == 200) {
    } else {
      showErrorSnackBar(result.body.toString());
    }

    return null;
  }

  showErrorSnackBar(String message) {
    final snackBar = new SnackBar(
      content: Text(
        message,
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red,
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.lightGreen[200],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              "Username:",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            TextField(
              readOnly: true,
              textAlign: TextAlign.center,
              controller: TextEditingController()..text = username,
              decoration: InputDecoration(hintText: "Username"),
            ),
            Text(
              "Worker Name:",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            TextField(
              readOnly: true,
              textAlign: TextAlign.center,
              controller: TextEditingController()..text = workerName,
              decoration: InputDecoration(hintText: "Worker Name"),
            ),
            Text(
              "Quantity:",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
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
                Navigator.pop(context);
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
