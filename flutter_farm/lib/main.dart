import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_farm/post.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Farm'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> users = new List();

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            users.length == 0
                ? RaisedButton(
                    elevation: 90,
                    color: Colors.white,
                    textColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () {
                      fetchData();
                    },
                    child: Text("Get All Users"),
                  )
                : Center(
                    child: Column(
                      children: <Widget>[
                        for (var user in users)
                          Text(user["Username"].toString() +
                              " " +
                              user["Password"].toString()),
                        RaisedButton(
                          elevation: 90,
                          color: Colors.white,
                          textColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          onPressed: () {
                            setState(() {
                              users = new List();
                            });
                          },
                          child: Text("Reset"),
                        )
                      ],
                    ),
                  ),
            RaisedButton(
              elevation: 90,
              color: Colors.white,
              textColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PostPage()));
              },
              child: Text("Add New User"),
            )
          ],
        ),
      ),
    );
  }
}
