import 'package:flutter/material.dart';

import 'home_page.dart';

class WorkerPage extends StatefulWidget {
  WorkerPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WorkerPageState createState() => _WorkerPageState();
}

class _WorkerPageState extends State<WorkerPage> {
  String qrCode = "";
  String quantity = "";

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
          children: <Widget>[
            TextField(
              textAlign: TextAlign.center,
              controller: TextEditingController()..text = qrCode,
              onChanged: (value) {
                qrCode = value;
              },
              decoration: InputDecoration(hintText: "QR Code"),
            ),
            TextField(
              textAlign: TextAlign.center,
              controller: TextEditingController()..text = quantity,
              onChanged: (value) {
                quantity = value;
              },
              decoration: InputDecoration(hintText: "Quantity"),
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
