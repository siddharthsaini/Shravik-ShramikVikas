import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:Shravik/models/user.dart';
import 'package:Shravik/ui/searchitem.dart';
import 'package:latlong/latlong.dart';

mainMapMarker(User user, BuildContext context) {
  return Marker(
    width: 80.0,
    height: 80.0,
    point: LatLng(
      user.lat.toDouble(),
      user.long.toDouble(),
    ),
    builder: (ctx) => Container(
      // width: 300,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(
              user.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(
              user.subadminarea,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 8,
                color: Colors.black,
              ),
            ),
          ),
          GestureDetector(
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
            },
            child: Icon(
              Icons.location_on,
              color: user.category == 'Worker' ? Colors.red : Colors.green,
              size: 30,
            ),
          ),
        ],
      ),
    ),
  );
}
