import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'api_url.dart';

class ReportsByWorkerPage extends StatefulWidget {
  ReportsByWorkerPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ReportsByWorkerPageState createState() => _ReportsByWorkerPageState();
}

class _ReportsByWorkerPageState extends State<ReportsByWorkerPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool ok = false;
  List<dynamic> workers = new List();
  List<dynamic> quantities = new List();
  String worker = '';

  @override
  void initState() {
    super.initState();
    fetchDataWorkers();
  }

  Future<List<String>> fetchDataWorkers() async {
    var url = ApiUrl.getAllWorkersUrl;
    var result = await http.get(url);
    if (result.statusCode != 200) {
      showErrorSnackBar(result.body.toString());
      return null;
    }
    var jsonResult = result.body;
    setState(() {
      workers = json.decode(jsonResult);
    });
    return null;
  }

  Future<List<String>> fetchDataQuantities(String selectedWorker) async {
    var url = ApiUrl.getQuantitiesByWorkerUrl +
        selectedWorker.replaceAll(new RegExp(r'\s'), '');
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
      backgroundColor: Colors.lightGreen[200],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: workers.length == 0
            ? Text('Wait!')
            : ok == false
                ? DataTable(
                    columns: [
                      DataColumn(
                        label: Padding(
                          padding: EdgeInsets.only(
                            left: 120.0,
                            right: 0.0,
                            top: 0.0,
                            bottom: 0.0,
                          ),
                          child: Text(
                            'Workers',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                      workers.length,
                      (index) => DataRow(
                        cells: <DataCell>[
                          DataCell(
                            Center(
                              child: Text(
                                workers[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                ok = true;
                                worker = workers[index];
                                fetchDataQuantities(workers[index]);
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  )
                : quantities.length == 0
                    ? Text('Wait')
                    : Center(
                        child: Column(
                          children: <Widget>[
                            Column(
                              children: [
                                Text(
                                  'Worker: ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                                Text(
                                  worker,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                            DataTable(
                              columns: <DataColumn>[
                                DataColumn(
                                  label: Text(
                                    'Quantity',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Plantation',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'User',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
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
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        quantities[index]['Harvest'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        quantities[index]['Username'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
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
                              child: Text('Back to Workers'),
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
