import 'package:flutter/material.dart';

class UserDP extends StatelessWidget {
  UserDP({this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        body: Center(
          child: Image.network(url),
        ),
      ),
    );
  }
}
