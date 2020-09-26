import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_farm/api_url.dart';

class ReportsByPlantationPage extends StatefulWidget {
  ReportsByPlantationPage({Key key, this.title, this.username})
      : super(key: key);

  final String title;
  final String username;

  @override
  _ReportsByPlantationPageState createState() =>
      _ReportsByPlantationPageState();
}

class _ReportsByPlantationPageState extends State<ReportsByPlantationPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool ok = false;
  List<dynamic> plantations = new List();
  List<dynamic> quantities = new List();

  String username = '';
  String plantation = '';

  @override
  void initState() {
    super.initState();
    fetchDataPlantations();
  }

  Future<List<String>> fetchDataPlantations() async {
    var url = ApiUrl.getAllPlantationsUrl;
    var result = await http.get(url);
    if (result.statusCode != 200) {
      showErrorSnackBar(result.body.toString());
      return null;
    }
    var jsonResult = result.body;
    setState(() {
      plantations = json.decode(jsonResult);
    });
    return null;
  }

  Future<List<String>> fetchDataQuantities(String selectedUser) async {
    var url = ApiUrl.getQuantitiesByPlantationUrl;
    var result = await http.get(url);
    if (result.statusCode != 200) {
      showErrorSnackBar(result.body.toString());
      return null;
    }
    var jsonResult = result.body;
    setState(() {
      quantities = json.decode(jsonResult);
    });
    return null;
  }

  showErrorSnackBar(String message) {
    final snackBar = new SnackBar(
      content: Text(
        message,
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red,
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.lightGreen[200],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: plantations.length == 0
            ? Center(
                child: Text(
                  'Wait!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              )
            : ok == false
                ? SingleChildScrollView(
                    child: DataTable(
                      columns: [
                        DataColumn(
                          label: Text(
                            'Plantations',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Users',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                      rows: List<DataRow>.generate(
                        plantations.length,
                        (index) => DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Text(
                                plantations[index]['Harvest'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  ok = true;
                                  username = plantations[index]['Username'];
                                  plantation = plantations[index]['Harvest'];
                                  fetchDataQuantities(
                                      plantations[index]['Username']);
                                });
                              },
                            ),
                            DataCell(
                              Text(
                                plantations[index]['Username'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  ok = true;
                                  username = plantations[index]['Username'];
                                  plantation = plantations[index]['Harvest'];
                                  fetchDataQuantities(
                                      plantations[index]['Username']);
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : quantities.length == 0
                    ? Center(
                        child: Text(
                          'Wait!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      )
                    : Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  'Plantation: ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                                Text(
                                  plantation,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'User: ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                                Text(
                                  username,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                            SingleChildScrollView(
                              child: DataTable(
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Text(
                                      'Quantity',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Worker',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                                rows: List<DataRow>.generate(
                                  quantities.length,
                                  (index) => DataRow(
                                    cells: <DataCell>[
                                      DataCell(
                                        Text(
                                          quantities[index]['Quantity']
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          quantities[index]['WorkerName'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            RaisedButton(
                              elevation: 90,
                              color: Colors.white,
                              textColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                'Back to Plantations',
                              ),
                              onPressed: () {
                                setState(() {
                                  ok = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
      ),
    );
  }
}
