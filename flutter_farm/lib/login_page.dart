import 'dart:async';
import 'dart:convert';

// import 'package:flutter_farm/web_api_services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:flutter_farm/worker_page.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String username = "";
  String password = "";

  List<dynamic> users = new List();

  _LoginPageState() {
    fetchData();
  }

  // Future<List<dynamic>> fetchData() async {
  //   users = await WebApiServices.users;
  // }

  Future<List<String>> fetchData() async {
    var result =
        await http.get('https://farmapi.conveyor.cloud/api/User/GetAllUsers');
    var jsonResult = result.body;
    setState(() {
      users = json.decode(jsonResult);
    });
    return null;
  }

  showErrorSnackBar() {
    final snackBar = new SnackBar(
      content: Text(
        'There is an error!',
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
            builder: (context) => WorkerPage(title: 'Worker'),
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
      backgroundColor: Colors.lightGreen[200],
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value == '') {
                  return 'Insert some text';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Username",
              ),
              textAlign: TextAlign.center,
              onChanged: (value) {
                username = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Password",
              ),
              validator: (value) {
                if (value == '') {
                  return 'Insert some text';
                }
                return null;
              },
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
            ),
            RaisedButton(
              elevation: 90,
              color: Colors.white,
              textColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(title: "Home")));
                }
              },
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
