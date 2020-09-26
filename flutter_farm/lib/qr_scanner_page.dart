import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';

import 'package:flutter_farm/worker_page.dart';

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() {
    return new _ScannerPageState();
  }
}

class _ScannerPageState extends State<ScannerPage> {
  String result = "Scan the QR Code";

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorkerPage(
            title: "Worker",
            qrCode: qrResult,
          ),
        ),
      );
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[200],
      appBar: AppBar(
        title: Text(
          "QR Scanner",
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: 0.0,
                top: 50.0,
                right: 0.0,
                bottom: 100.0,
              ),
              child: Image(
                image: AssetImage('lib/assets/qr-code.png'),
                width: 200,
                alignment: Alignment.topLeft,
              ),
            ),
            Text(
              result,
              style: new TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.camera_alt,
        ),
        label: Text(
          "Scan",
        ),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
