import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiUrl {
  static String getAllUsersURL =
      'https://farmapi.conveyor.cloud/api/User/GetAllUsers';
  static String getAllWorkersURL =
      'https://farmapi.conveyor.cloud/api/Worker/GetAllWorkers';
  static String postNewUserURL =
      'https://farmapi.conveyor.cloud/api/User/AddUser';
}

class WebApiServices {
  static List<dynamic> _getData;

  static List<dynamic> get users {
    _fetchData(ApiUrl.getAllUsersURL);
    return _getData;
  }

  static List<dynamic> get workers {
    _fetchData(ApiUrl.getAllWorkersURL);
    return _getData;
  }

  static Future<List<String>> _fetchData(String apiUrl) async {
    var result = await http.get(apiUrl);
    var jsonResult = result.body;
    _getData = json.decode(jsonResult);
    return null;
  }

  Future<List<String>> postNewUser({
    @required String username,
    @required String name,
    @required String password,
    @required String cnp,
    @required String address,
    @required String email,
    @required GlobalKey<ScaffoldState> scaffoldKey,
  }) async {
    var body = jsonEncode({
      "Username": username,
      "Password": password,
      "Name": name,
      "CNP": cnp,
      "Address": address,
      "Email": email
    });

    var result = await http.post(
      ApiUrl.postNewUserURL,
      body: body,
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );

    if (result.statusCode == 200) {
      final snackBar = new SnackBar(
        content: Text(
          "There is an error!",
          style: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 20),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
      );

      scaffoldKey.currentState.showSnackBar(snackBar);
      // } else {
      //   showErrorSnackBar();
      // }

      return null;
    }
  }
}
