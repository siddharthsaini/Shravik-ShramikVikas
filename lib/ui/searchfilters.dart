import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Shravik/localizations.dart';
import 'package:Shravik/ui/searchresults.dart';
import 'components/jobcheckbox.dart';

class SearchFilters extends StatefulWidget {
  SearchFilters({this.category});
  final String category;

  @override
  _SearchFiltersState createState() => _SearchFiltersState();
}

class _SearchFiltersState extends State<SearchFilters> {
  Future<QuerySnapshot> userDocs;

  var dropdownValue = 'address';

  List<dynamic> _job = ['Others'];

  void submitAddress(String searchValue) async {
    Future<QuerySnapshot> users = Firestore.instance
        .collection("users")
        .where("category",
            isEqualTo: widget.category == 'Worker' ? 'Worker' : 'Employer')
        .where("job", arrayContainsAny: _job)
        .where(dropdownValue, isLessThanOrEqualTo: searchValue)
        .getDocuments();

    setState(() {
      userDocs = users;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResults(userDocs),
        ),
      );
    });
  }

  void submitRest(String searchValue) async {
    Future<QuerySnapshot> users = Firestore.instance
        .collection("users")
        .where("category",
            isEqualTo: widget.category == 'Worker' ? 'Worker' : 'Employer')
        .where("job", arrayContainsAny: _job)
        .where(dropdownValue, isGreaterThanOrEqualTo: searchValue)
        .getDocuments();

    setState(() {
      userDocs = users;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResults(userDocs),
        ),
      );
    });
  }

  searchUsers(String submit) {
    dropdownValue == 'address' ? submitAddress(submit) : submitRest(submit);
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    String search;
    return SafeArea(
      child: Scaffold(
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            searchUsers(search);
          },
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          label: Text(
            labels.auth.searchUser,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    widget.category == 'Worker'
                        ? labels.auth.searchMig
                        : labels.auth.searchEmp,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text(
                              labels.auth.filter,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              labels.auth.chooseBoth,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.red[600],
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 20, 13),
                              child: JobCheckbox(
                                onPress: (value) {
                                  if (value == null) return;
                                  setState(() {
                                    List<dynamic> job = value;
                                    _job = job;
                                  });
                                },
                                title: labels.auth.servicesReqd,
                              ),
                            ),
                          ),
                          DropdownButton<String>(
                            value: dropdownValue,
                            icon: Icon(
                              Icons.arrow_downward,
                            ),
                            iconSize: 24,
                            elevation: 16,
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                            },
                            items: <String>['name', 'phone', 'email', 'address']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value.toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      Form(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText:
                                  "${labels.auth.searchUser} $dropdownValue:",
                              prefixIcon: Icon(Icons.search),
                            ),
                            onFieldSubmitted: (value) {
                              search = value;
                              searchUsers(search);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
