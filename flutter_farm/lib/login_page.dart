import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_farm/worker_page.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String username = "";
  String password = "";

  List<dynamic> users = new List();

  _LoginPageState() {
    fetchData();
  }

  Future<List<String>> fetchData() async {
    var result =
        await http.get("https://farmapi.conveyor.cloud/api/User/GetAllUsers");
    var jsonResult = result.body;
    setState(() {
      users = json.decode(jsonResult);
    });
    return null;
  }

  showErrorSnackBar() {
    final snackBar = new SnackBar(
      content: Text(
        "There is an error!",
        style: TextStyle(
            fontFamily: 'OpenSans', fontWeight: FontWeight.bold, fontSize: 20),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red,
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void verifyCredentials() {
    for (var user in users) {
      if (user['Username'] == username && user['Password'] == password) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WorkerPage(title: "Worker"),
          ),
        );
        return;
      }
    }
    showErrorSnackBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              textAlign: TextAlign.center,
              controller: TextEditingController()..text = username,
              onChanged: (value) {
                username = value;
              },
              decoration: InputDecoration(hintText: "Username"),
            ),
            TextField(
              textAlign: TextAlign.center,
              controller: TextEditingController()..text = password,
              onChanged: (value) {
                password = value;
              },
              decoration: InputDecoration(hintText: "Password"),
            ),
            RaisedButton(
              elevation: 90,
              color: Colors.white,
              textColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              onPressed: () {
                verifyCredentials();
              },
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
