import 'package:flutter/material.dart';

class ReusableLogo extends StatelessWidget {
  const ReusableLogo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        Icons.people,
        color: Colors.white,
        size: 90,
      ),
      width: 130.0,
      height: 130.0,
      decoration: new BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[900], Colors.blue[500]],
        ),
        borderRadius: new BorderRadius.all(new Radius.circular(100.0)),
      ),
    );
  }
}
