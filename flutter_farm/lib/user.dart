import 'package:flutter/material.dart';

class User extends StatelessWidget {
  final String username;
  final String name;

  User({
    @required this.username,
    @required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Username: '),
            Text(username),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: '),
            Text(name),
          ],
        ),
        Text(' '),
      ],
    );
  }
}
