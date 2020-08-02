import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Shravik/constants/globals.dart';
import 'package:Shravik/ui/components/gradientbutton.dart';
import 'package:Shravik/ui/mainmap.dart';
import 'package:Shravik/ui/search.dart';
import 'package:Shravik/ui/share.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:Shravik/localizations.dart';
import 'package:Shravik/services/services.dart';
import 'package:Shravik/models/models.dart';
import 'package:Shravik/ui/components/components.dart';
import 'dp.dart';

class HomeUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 2;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    WhoAreU(),
    MainMapPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text("Search/खोजें"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            title: Text('Map/नक्शा'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profile/रूपरेखा'),
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey[500],
        selectedItemColor: Colors.blue[500],
        onTap: _onItemTapped,
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _loading = true;
  String _uid = '';
  String _name = '';
  String _email = '';
  String _phone = '';
  String _category = '';
  String _admin = '';
  String _about = '';
  String _address = '';
  String _sublocality = '';
  String _locality = '';
  String _subadminarea = '';
  String _adminarea = '';
  Position _position;
  List<dynamic> _job = [''];
  String _exp = '';
  String _url = '';

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    final UserModel user = Provider.of<UserModel>(context);
    if (user != null) {
      setState(() {
        _loading = false;
        _uid = user.uid;
        _name = user.name;
        _email = user.email;
        _phone = user.phone;
        _category = user.category;
        _sublocality = user.sublocality;
        _locality = user.locality;
        _subadminarea = user.subadminarea;
        _adminarea = user.adminarea;
        _about = user.about;
        _job = user.job;
        _exp = user.exp;
        _url = user.photoUrl;
      });
    } else {
      // setState(() async {
      //   thisUser = await FirebaseAuth.instance.currentUser();
      // });
      // Navigator.of(context).pushNamed('/category');
    }

    _isUserAdmin();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Text(
          labels.auth.welcometitle,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        leading: shareIcon(Icon(
          Icons.share,
          color: Colors.white,
        )),
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/settings');
              }),
        ],
      ),
      body: LoadingScreen(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
              child: Column(
                children: <Widget>[
                  // SizedBox(height: 120),
                  ListTile(
                    title: Text(labels.settings.language),
                    //trailing: _languageDropdown(context),
                    trailing: DropdownPicker(
                      menuOptions: Globals.languageOptions,
                      selectedOption: Provider.of<LanguageProvider>(context)
                          .currentLanguage,
                      onChanged: (value) {
                        Provider.of<LanguageProvider>(context, listen: false)
                            .updateLanguage(value);
                      },
                    ),
                  ),
                  GestureDetector(
                    child: Avatar(user, _category),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDP(
                            url: _url,
                          ),
                        ),
                      );
                    },
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 14, 0, 8),
                        child: Text(
                          _name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            // color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [Colors.blue[900], Colors.blue[400]],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.phone_in_talk,
                                      color: Colors.grey[300],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      _phone,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                _email == ""
                                    ? Container()
                                    : Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.email,
                                                color: Colors.grey[300],
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                _email,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              labels.auth.category,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              _category == 'Worker'
                                  ? labels.auth.radio1
                                  : labels.auth.radio2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          // width: double.infinity,
                          decoration: BoxDecoration(
                            // color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: _category == 'Worker'
                                  ? [Colors.red[800], Colors.red[500]]
                                  : [Colors.green[800], Colors.green[500]],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _category == 'Worker'
                                        ? labels.auth.yourJob
                                        : labels.auth.servicesReqd,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    jobText(_job),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 21,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              _category == 'Worker'
                                  ? labels.auth.experience
                                  : labels.auth.company,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              _exp,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: Container(
                          width: double.infinity,
                          height: 2,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              labels.auth.residence,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '$_locality,\n$_subadminarea,\n$_adminarea',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: _category == 'Worker'
                                  ? [Colors.red[800], Colors.red[500]]
                                  : [Colors.green[800], Colors.green[500]],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    labels.auth.aboutYou,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    _about,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 21,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RaisedButton(
                      color: Colors.blue[800],
                      onPressed: () async {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          backgroundColor: Colors.green[600],
                          content: Text(labels.auth.updatingLocation),
                        ));
                        final firestoreInstance = Firestore.instance;

                        _position = await Geolocator().getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.high);
                        final coordinates = new Coordinates(
                            _position.latitude, _position.longitude);
                        var addresses = await Geocoder.local
                            .findAddressesFromCoordinates(coordinates);
                        var first = addresses.first;
                        _address = first.addressLine;
                        _sublocality = first.subLocality;
                        _locality = first.subLocality;
                        _subadminarea = first.subAdminArea;
                        _adminarea = first.adminArea;

                        await FirebaseAuth.instance.currentUser();
                        firestoreInstance
                            .collection("users")
                            .document(_uid)
                            .updateData({
                          "address": _address,
                          "sublocality": _sublocality,
                          "locality": _locality,
                          "subadminarea": _subadminarea,
                          "adminarea": _adminarea,
                        }).then((_) {
                          setState(() {});
                        });
                      },
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.my_location),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            labels.auth.updateLocation,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RaisedGradientButton(
                        onPressed: share,
                        height: 55,
                        gradient: LinearGradient(
                            colors: [Colors.green[900], Colors.green[500]]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.share,
                              color: Colors.white,
                            ),
                            SizedBox(width: 20),
                            Text(labels.auth.shareApp,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
        inAsyncCall: _loading,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }

  _isUserAdmin() async {
    bool _isAdmin = await AuthService().isAdmin();
    if (mounted) {
      setState(() {
        _admin = _isAdmin.toString();
      });
    }
  }
}

String jobText(List<dynamic> jobs) {
  String job;
  job = jobs.toString().replaceAll('[', '').replaceAll(']', '');
  return job;
}
