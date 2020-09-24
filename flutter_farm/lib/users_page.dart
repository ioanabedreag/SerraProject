import 'package:flutter/material.dart';

import 'package:flutter_farm/user.dart';
import 'package:flutter_farm/web_api_services.dart';

class Users extends StatefulWidget {
  Users({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List<dynamic> users = new List();

  _UsersState() {
    users = WebApiServices.users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[200],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            users.length == 0
                ? Center(
                    child: Text('Wait!'),
                  )
                : Center(
                    child: Column(
                      children: <Widget>[
                        for (var user in users)
                          User(
                            username: user['Username'],
                            name: user['Name'],
                          ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
