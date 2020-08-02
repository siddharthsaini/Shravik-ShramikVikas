import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

getMarker(double lat, long, String category, name) {
  return Marker(
    width: 80.0,
    height: 80.0,
    point: LatLng(
      lat,
      long,
    ),
    builder: (ctx) => Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10,
                color: Colors.black,
              ),
            ),
          ),
          Icon(
            Icons.location_on,
            color: category == 'Worker' ? Colors.red : Colors.green,
            size: 30,
          ),
        ],
      ),
    ),
  );
}
