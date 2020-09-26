import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_farm/api_url.dart';

class NewWorkerPage extends StatefulWidget {
  NewWorkerPage({Key key}) : super(key: key);

  @override
  _NewWorkerPageState createState() => _NewWorkerPageState();
}

class _NewWorkerPageState extends State<NewWorkerPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String workername = "";

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
      "WorkerName": workername,
    });

    var result = await http.post(
      ApiUrl.addWorkerUrl,
      body: body,
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );
    if (result.statusCode == 200) {
      showPostSnackBar();
      Navigator.pop(context);
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
        title: Text("Add New Worker"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: 0.0,
                  top: 50.0,
                  right: 0.0,
                  bottom: 50.0,
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
                  hintText: "Name",
                ),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  workername = value;
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
                  if (_formKey.currentState.validate()) {
                    postData();
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
