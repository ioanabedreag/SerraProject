import 'package:flutter/material.dart';
import 'package:flutter_farm/reports_by_plantation_page.dart';

import 'package:flutter_farm/reports_by_worker_page.dart';
import 'package:flutter_farm/worker_page.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key, this.title, @required this.username}) : super(key: key);

  final String title;
  final String username;

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[200],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                        MaterialPageRoute(builder: (context) => WorkerPage()));
                  },
                  child: Text('Scan QR Code'),
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
                            builder: (context) => ReportsByWorkerPage(
                                  title: 'Reports',
                                )));
                  },
                  child: Text('View reports by worker'),
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
                            builder: (context) => ReportsByPlantationPage(
                                  title: 'Reports',
                                )));
                  },
                  child: Text('View reports by plantation'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
