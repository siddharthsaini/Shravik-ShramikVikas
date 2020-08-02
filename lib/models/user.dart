import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
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
  final List<dynamic> job;
  final String exp;
  final double lat;
  final double long;

  const User({
    this.uid,
    this.name,
    this.phone,
    this.email,
    this.photoUrl,
    this.category,
    this.about,
    this.address,
    this.sublocality,
    this.locality,
    this.subadminarea,
    this.adminarea,
    this.job,
    this.exp,
    this.lat,
    this.long,
  });

  factory User.fromDocument(DocumentSnapshot document) {
    return User(
      uid: document['uid'],
      name: document['name'],
      phone: document['phone'],
      email: document['email'],
      photoUrl: document['photoUrl'],
      category: document['category'],
      about: document['about'],
      address: document['address'],
      sublocality: document['sublocality'],
      locality: document['locality'],
      subadminarea: document['subadminarea'],
      adminarea: document['adminarea'],
      job: document['job'],
      exp: document['exp'],
      lat: document['lat'],
      long: document['long'],
    );
  }
}
