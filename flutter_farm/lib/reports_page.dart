import 'package:flutter/material.dart';

class ReportsPage extends StatefulWidget {
  ReportsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
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
          child: DataTable(
        columns: [
          DataColumn(label: Text('Workers')),
        ],
        rows: [
          DataRow(
            cells: [DataCell(Text('Something Random'))],
            selected: true,
            onSelectChanged: (value) {
              setState(() {});
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => UserPage(title: "Worker")));
            },
          ),
          DataRow(cells: [DataCell(Text('Something Random'))], selected: true),
          DataRow(cells: [DataCell(Text('Something Random'))], selected: true)
        ],
      )),
    );
  }
}
