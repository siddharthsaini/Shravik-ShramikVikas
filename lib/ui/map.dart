import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:Shravik/models/user_model.dart';
import 'package:Shravik/ui/mapmarker.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

import '../localizations.dart';

class MapPage extends StatefulWidget {
  MapPage({
    this.lat,
    this.long,
    this.category,
    this.name,
  });
  final double lat, long;
  final String category, name;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserModel>(context);
    final labels = AppLocalizations.of(context);

    var pointsGradient = <LatLng>[
      LatLng(user.lat, user.long),
      LatLng(widget.lat, widget.long),
    ];

    final Distance distance = Distance();

    double totalDistanceInKm = 0;

    totalDistanceInKm += distance.as(
      LengthUnit.Kilometer,
      LatLng(user.lat, user.long),
      LatLng(widget.lat, widget.long),
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: widget.lat != null
          ? Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    center: LatLng(
                      widget.lat,
                      widget.long,
                    ),
                    zoom: 10.0,
                  ),
                  layers: [
                    TileLayerOptions(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c']),
                    PolylineLayerOptions(
                      polylines: [
                        Polyline(
                          points: pointsGradient,
                          strokeWidth: 4.0,
                          gradientColors: [
                            user.category == 'Worker'
                                ? Colors.red
                                : Colors.green,
                            widget.category == 'Worker'
                                ? Colors.red
                                : Colors.green,
                          ],
                        ),
                      ],
                    ),
                    MarkerLayerOptions(
                      markers: [
                        getMarker(
                          user.lat,
                          user.long,
                          user.category,
                          labels.auth.you,
                        ),
                        getMarker(
                          widget.lat,
                          widget.long,
                          widget.category,
                          widget.name,
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "${labels.auth.distance}: $totalDistanceInKm KM",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Container(
              alignment: FractionalOffset.center,
              child: CircularProgressIndicator()),
    );
  }
}
