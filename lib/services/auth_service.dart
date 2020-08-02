import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_gravatar/simple_gravatar.dart';
import 'package:Shravik/models/models.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Future<FirebaseUser> get getUser => _auth.currentUser();

  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  Stream<UserModel> streamFirestoreUser(FirebaseUser firebaseUser) {
    if (firebaseUser?.uid != null) {
      return _db
          .document('/users/${firebaseUser.uid}')
          .snapshots()
          .map((snapshot) => UserModel.fromMap(snapshot.data));
    }
    return null;
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> registerWithEmailAndPassword(
    String name,
    String email,
    String password,
    String number,
    String category,
    String about,
    String address,
    String sublocality,
    String locality,
    String subadminarea,
    String adminarea,
    String url,
    List<dynamic> job,
    String exp,
    double lat,
    double long,
  ) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: number + '@shravik.in', password: password)
          .then((result) async {
        if (url == null) {
          Gravatar gravatar = Gravatar(email);
          String gravatarUrl = gravatar.imageUrl(
            size: 200,
            defaultImage: GravatarImage.retro,
            rating: GravatarRating.pg,
            fileExtension: true,
          );
          url = gravatarUrl;
        } else {}
        UserModel _newUser = UserModel(
          uid: result.user.uid,
          email: email,
          name: name,
          phone: number,
          photoUrl: url,
          category: category,
          about: about,
          address: address,
          sublocality: sublocality,
          locality: locality,
          subadminarea: subadminarea,
          adminarea: adminarea,
          lat: lat,
          long: long,
          job: job,
          exp: exp,
        );
        _updateUserFirestore(_newUser, result.user);
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUser(
      UserModel user, String oldEmail, String password) async {
    bool _result = false;
    await _auth
        .signInWithEmailAndPassword(email: oldEmail, password: password)
        .then((_firebaseUser) {
      _firebaseUser.user.updateEmail(user.email);
      _updateUserFirestore(user, _firebaseUser.user);
      _result = true;
    });
    return _result;
  }

  void _updateUserFirestore(UserModel user, FirebaseUser firebaseUser) {
    _db
        .document('/users/${firebaseUser.uid}')
        .setData(user.toJson(), merge: true);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<bool> isAdmin() async {
    bool _isAdmin = false;
    await _auth.currentUser().then((user) async {
      DocumentSnapshot adminRef =
          await _db.collection('admin').document(user?.uid).get();
      if (adminRef.exists) {
        _isAdmin = true;
      }
    });
    return _isAdmin;
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
