import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:Shravik/models/user.dart';
import 'package:Shravik/models/user_model.dart';
import 'package:Shravik/ui/mainmapmarker.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

import '../localizations.dart';

class MainMapPage extends StatefulWidget {
  @override
  _MainMapPageState createState() => _MainMapPageState();
}

class _MainMapPageState extends State<MainMapPage> {
  // bool _loading = true;
  String uid = '';
  String adminarea = '';
  Future<QuerySnapshot> userDocs;
  double lat, long;

  List buildSearchResults(List<DocumentSnapshot> docs) {
    List<Marker> userSearchItems = [];

    docs.forEach((DocumentSnapshot doc) {
      User user = User.fromDocument(doc);
      Marker searchItem = mainMapMarker(user, context);
      userSearchItems.add(searchItem);
    });
    return userSearchItems;
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserModel>(context);
    final labels = AppLocalizations.of(context);

    // setState(() {
    if (user != null) {
      adminarea = user.adminarea;
      lat = user.lat;
      long = user.long;
    }
    // });

    Future<QuerySnapshot> users = Firestore.instance
        .collection("users")
        .where("adminarea", isEqualTo: adminarea)
        .getDocuments();

    setState(() {
      userDocs = users;
    });

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //   },
      //   child: Icon(
      //     Icons.search,
      //     color: Colors.white,
      //   ),
      // ),
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
              future: userDocs,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FlutterMap(
                    options: MapOptions(
                      center: LatLng(lat, long),
                      zoom: 9.0,
                    ),
                    layers: [
                      TileLayerOptions(
                          urlTemplate:
                              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                          subdomains: ['a', 'b', 'c']),
                      MarkerLayerOptions(
                        markers: buildSearchResults(snapshot.data.documents),
                      ),
                    ],
                  );
                } else {
                  return Container(
                      alignment: FractionalOffset.center,
                      child: CircularProgressIndicator());
                }
              }),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          adminarea,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.red,
                              ),
                              Text(
                                " =  ${labels.auth.radio1}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.green,
                              ),
                              Text(
                                " =  ${labels.auth.radio2}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
