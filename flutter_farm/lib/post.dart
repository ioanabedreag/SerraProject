import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:flutter_farm/home_page.dart';

class PostPage extends StatefulWidget {
  PostPage({Key key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String username = "";
  String password = "";
  String name = "";
  String cnp = "";
  String address = "";
  String email = "";

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
      "Email": email
    });

    var result = await http.post(
      "https://farmapi.conveyor.cloud/api/User/AddUser",
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
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Add New User"),
      ),
      body: Center(
        child: Column(
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
            TextField(
              textAlign: TextAlign.center,
              controller: TextEditingController()..text = name,
              onChanged: (value) {
                name = value;
              },
              decoration: InputDecoration(hintText: "Name"),
            ),
            TextField(
              textAlign: TextAlign.center,
              controller: TextEditingController()..text = cnp,
              onChanged: (value) {
                cnp = value;
              },
              decoration: InputDecoration(hintText: "CNP"),
            ),
            TextField(
              textAlign: TextAlign.center,
              controller: TextEditingController()..text = address,
              onChanged: (value) {
                address = value;
              },
              decoration: InputDecoration(hintText: "Address"),
            ),
            TextField(
              textAlign: TextAlign.center,
              controller: TextEditingController()..text = email,
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(hintText: "Email"),
            ),
            RaisedButton(
              elevation: 90,
              color: Colors.white,
              textColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              onPressed: () {
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
