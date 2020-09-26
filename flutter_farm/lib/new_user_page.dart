import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:flutter_farm/api_url.dart';

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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: 0.0,
                  top: 10.0,
                  right: 0.0,
                  bottom: 10.0,
                ),
                child: Image(
                  image: AssetImage('lib/assets/register.png'),
                  width: 200,
                  alignment: Alignment.topLeft,
                ),
              ),
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
                  RegExp exp = new RegExp(
                    r"^\d{13}$",
                  );
                  if (exp.hasMatch(value) == false) {
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
                  RegExp exp = new RegExp(
                    r"^[A-Za-z0-9._]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$",
                  );
                  if (exp.hasMatch(value) == false) {
                    return 'Insert a valid email!';
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
                    sleep(const Duration(seconds: 5));
                    Navigator.pop(context);
                  }
                },
                child: Text("Done"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
