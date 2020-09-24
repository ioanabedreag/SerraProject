import 'package:flutter/material.dart';

import 'package:flutter_farm/new_user_page.dart';
import 'package:flutter_farm/worker_page.dart';

import 'login_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: 0.0, top: 50.0, right: 0.0, bottom: 100.0),
              child: Image(
                image: AssetImage('lib/assets/farm.png'),
                width: 200,
                alignment: Alignment.topLeft,
              ),
            ),
            Column(
              children: <Widget>[
                RaisedButton(
                  elevation: 90,
                  color: Colors.white,
                  textColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text('Login'),
                ),
                RaisedButton(
                  elevation: 90,
                  color: Colors.white,
                  textColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewUserPage()));
                  },
                  child: Text('Add New User'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
