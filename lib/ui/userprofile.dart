import 'package:flutter/material.dart';
import 'package:Shravik/ui/map.dart';
import '../localizations.dart';
import 'components/gradientbutton.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home_ui.dart';
import 'dp.dart';

class UserProfile extends StatelessWidget {
  final String email;
  final String name;
  final String phone;
  final String photoUrl;
  final String category;
  final String about;
  final String address;
  final String sublocality;
  final String locality;
  final String subadminarea;
  final String adminarea;
  final List<dynamic> job; //
  final String exp;
  final double lat;
  final double long;

  UserProfile({
    this.email,
    this.name,
    this.photoUrl,
    this.phone,
    this.category,
    this.about,
    this.address,
    this.adminarea,
    this.locality,
    this.subadminarea,
    this.sublocality,
    this.job,
    this.exp,
    this.lat,
    this.long,
  });

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        backgroundColor: Colors.blue[800],
        title: Text(
          labels.auth.userProfile,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 20, 5, 10),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDP(
                          url: photoUrl,
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                      foregroundColor: Colors.blue,
                      backgroundColor:
                          category == 'Employer' ? Colors.green : Colors.red,
                      radius: 65.0,
                      child: ClipOval(
                        child: Image.network(
                          photoUrl,
                          fit: BoxFit.cover,
                          width: 120.0,
                          height: 120.0,
                        ),
                      )),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 14, 0, 8),
                      child: Text(
                        name,
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
                                    phone,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              email == ""
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
                                              email,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
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
                            category == 'Worker'
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: category == 'Worker'
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
                                  category == 'Worker'
                                      ? labels.auth.job
                                      : labels.auth.servicesReqd,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  jobText(job),
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
                            category == 'Worker'
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
                            exp,
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
                            '$locality,\n$subadminarea,\n$adminarea',
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
                            colors: category == 'Worker'
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
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  about,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
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
                      padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
                      child: RaisedGradientButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapPage(
                                name: name,
                                category: category,
                                lat: lat,
                                long: long,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              labels.auth.openinmap,
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        height: 60,
                        gradient: LinearGradient(
                          colors: [Colors.blue[800], Colors.blue[500]],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[300],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(26, 20, 26, 10),
                                child: RaisedGradientButton(
                                  onPressed: () => customLauncher('tel:$phone'),
                                  child: Text(
                                    labels.auth.call,
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  height: 60,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.green[800],
                                      Colors.green[500]
                                    ],
                                  ),
                                ),
                              ),
                              email == ""
                                  ? SizedBox(
                                      height: 13,
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          26, 10, 26, 20),
                                      child: RaisedGradientButton(
                                        onPressed: () =>
                                            customLauncher('mailto:$email'),
                                        child: Text(
                                          labels.auth.email,
                                          style: TextStyle(
                                            fontSize: 22,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        height: 60,
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.red[800],
                                            Colors.red[500]
                                          ],
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void customLauncher(command) async {
  if (await canLaunch(command)) {
    await launch(command);
  } else {
    null;
  }
}
