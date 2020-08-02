import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Shravik/models/user.dart';
import 'package:Shravik/ui/searchitem.dart';

import '../localizations.dart';

class SearchResults extends StatelessWidget {
  final Future<QuerySnapshot> userDocs;
  SearchResults(this.userDocs);

  ListView buildSearchResults(List<DocumentSnapshot> docs) {
    List<UserSearchItem> userSearchItems = [];

    docs.forEach((DocumentSnapshot doc) {
      User user = User.fromDocument(doc);
      UserSearchItem searchItem = UserSearchItem(user);
      userSearchItems.add(searchItem);
    });

    return ListView(
      children: userSearchItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        label: Text(
          labels.auth.searchAgain,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: userDocs,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return buildSearchResults(snapshot.data.documents);
            } else {
              return Container(
                  alignment: FractionalOffset.center,
                  child: CircularProgressIndicator());
            }
          }),
    );
  }
}
