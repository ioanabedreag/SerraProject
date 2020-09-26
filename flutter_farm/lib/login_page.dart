import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_farm/user_page.dart';
import 'package:flutter_farm/api_url.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String username = "";
  String password = "";
  bool ok = false;

  List<dynamic> users = new List();

  Future<List<String>> fetchData() async {
    var url =
        ApiUrl.getUserUrl + 'username=' + username + '&password=' + password;
    var result = await http.get(url);
    if (result.body == "null") {
      showErrorSnackBar();
      return null;
    }

    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserPage(
                  title: "User",
                  username: username,
                )));
    return null;
  }

  showErrorSnackBar() {
    final snackBar = new SnackBar(
      content: Text(
        'There is no such user!',
        style: TextStyle(
            fontFamily: 'OpenSans', fontWeight: FontWeight.bold, fontSize: 20),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red,
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[200],
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: 0.0,
                  top: 50.0,
                  right: 0.0,
                  bottom: 20.0,
                ),
                child: Image(
                  image: AssetImage('lib/assets/login.png'),
                  width: 100,
                  alignment: Alignment.topLeft,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Username",
                ),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  username = value;
                },
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                ),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
              ),
              Text(' '),
              Text(' '),
              RaisedButton(
                elevation: 90,
                color: Colors.white,
                textColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onPressed: () {
                  fetchData();
                },
                child: Text(
                  "Login",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
