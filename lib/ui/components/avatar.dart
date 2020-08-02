import 'package:flutter/material.dart';
import 'package:Shravik/models/models.dart';
import 'package:Shravik/ui/components/components.dart';

class Avatar extends StatelessWidget {
  Avatar(
    this.user,
    this.type,
  );
  final UserModel user;
  final String type;

  @override
  Widget build(BuildContext context) {
    if ((user?.photoUrl == '') || (user?.photoUrl == null)) {
      return LogoGraphicHeader();
    }
    return Hero(
      tag: 'User Avatar Image',
      child: CircleAvatar(
          foregroundColor: Colors.blue,
          backgroundColor: type == 'Employer' ? Colors.green : Colors.red,
          radius: 65.0,
          child: ClipOval(
            child: Image.network(
              user?.photoUrl,
              fit: BoxFit.cover,
              width: 120.0,
              height: 120.0,
            ),
          )),
    );
  }
}
