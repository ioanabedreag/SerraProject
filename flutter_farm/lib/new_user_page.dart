import 'dart:convert';
// import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter_farm/web_api_services.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:flutter_farm/home_page.dart';

import 'api_url.dart';

class NewUserPage extends StatefulWidget {
  NewUserPage({Key key}) : super(key: key);

  @override
  _NewUserPageState createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String username = "";
  String password = "";
  String name = "";
  String cnp = "";
  String address = "";
  String email = "";
  String plantation = "";

  @override
  void initState() {
    super.initState();
  }

  showErrorSnackBar() {
    final snackBar = new SnackBar(
      content: Text(
        "There is an error!",
        style: TextStyle(
            fontFamily: 'OpenSans', fontWeight: FontWeight.bold, fontSize: 20),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.green,
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  showPostSnackBar() {
    final snackBar = new SnackBar(
      content: Text(
        "Success!",
        style: TextStyle(
            fontFamily: 'OpenSans', fontWeight: FontWeight.bold, fontSize: 20),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.green,
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Future<List<String>> postData() async {
    var body = jsonEncode({
      "Username": username,
      "Password": password,
      "Name": name,
      "CNP": cnp,
      "Address": address,
      "Email": email,
      "Plantation": plantation
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
      showPostSnackBar();
    } else {
      showErrorSnackBar();
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[200],
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Add New User"),
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
              obscureText: true,
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
            TextFormField(
              textAlign: TextAlign.center,
              validator: (value) {
                if (value == '') {
                  return 'Insert some text';
                }
                return null;
              },
              onChanged: (value) {
                name = value;
              },
              decoration: InputDecoration(hintText: "Name"),
            ),
            TextFormField(
              textAlign: TextAlign.center,
              validator: (value) {
                if (value == '' || value.length != 13) {
                  return 'Insert a valid CNP';
                }
                return null;
              },
              onChanged: (value) {
                cnp = value;
              },
              decoration: InputDecoration(hintText: "CNP"),
            ),
            TextFormField(
              textAlign: TextAlign.center,
              validator: (value) {
                if (value == '') {
                  return 'Insert some text';
                }
                return null;
              },
              onChanged: (value) {
                address = value;
              },
              decoration: InputDecoration(hintText: "Address"),
            ),
            TextFormField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              validator: (value) {
                if (value == '') {
                  return 'Insert some text';
                }
                return null;
              },
              decoration: InputDecoration(hintText: "Email"),
            ),
            TextFormField(
              textAlign: TextAlign.center,
              validator: (value) {
                if (value == '') {
                  return 'Insert some text';
                }
                return null;
              },
              onChanged: (value) {
                plantation = value;
              },
              decoration: InputDecoration(hintText: "Plantation"),
            ),
            RaisedButton(
              elevation: 90,
              color: Colors.white,
              textColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  postData();
                  // sleep(const Duration(seconds: 5));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(title: "Home")));
                }
              },
              child: Text("Done"),
            )
          ],
        ),
      ),
    );
  }
}
