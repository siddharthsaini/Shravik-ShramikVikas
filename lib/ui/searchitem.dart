import "package:flutter/material.dart";
import 'package:Shravik/models/user.dart';
import 'package:Shravik/ui/userprofile.dart';

class UserSearchItem extends StatelessWidget {
  final User user;

  const UserSearchItem(this.user);

  @override
  Widget build(BuildContext context) {
    TextStyle boldStyle = TextStyle(
      fontWeight: FontWeight.bold,
    );

    return GestureDetector(
        child: ListTile(
          leading: CircleAvatar(
              foregroundColor: Colors.blue,
              backgroundColor:
                  user.category == 'Employer' ? Colors.green : Colors.red,
              radius: 30.0,
              child: ClipOval(
                child: Image.network(
                  user.photoUrl,
                  fit: BoxFit.cover,
                  width: 50.0,
                  height: 50.0,
                ),
              )),
          title: Text(user.name, style: boldStyle),
          subtitle:
              Text('${user.locality}, ${user.subadminarea}, ${user.adminarea}'),
        ),
        onTap: () {
          openProfile(
            context,
            user.email,
            user.name,
            user.phone,
            user.photoUrl,
            user.category,
            user.about,
            user.address,
            user.sublocality,
            user.locality,
            user.subadminarea,
            user.adminarea,
            user.job,
            user.exp,
            user.lat,
            user.long,
          );
        });
  }
}

void openProfile(
  BuildContext context,
  String email,
  String name,
  String phone,
  String photoUrl,
  String category,
  String about,
  String address,
  String sublocality,
  String locality,
  String subadminarea,
  String adminarea,
  List<dynamic> job,
  String exp,
  double lat,
  double long,
) {
  Navigator.of(context)
      .push(MaterialPageRoute<bool>(builder: (BuildContext context) {
    return UserProfile(
      name: name,
      phone: phone,
      email: email,
      photoUrl: photoUrl,
      category: category,
      about: about,
      address: address,
      sublocality: sublocality,
      locality: locality,
      subadminarea: subadminarea,
      adminarea: adminarea,
      job: job,
      exp: exp,
      lat: lat,
      long: long,
    );
  }));
}
