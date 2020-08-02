import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Shravik/ui/components/reusablelogo.dart';

class Splash extends StatefulWidget {
  static const String id = 'splash_screen';

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  initState() {
    super.initState();
    new Timer(const Duration(seconds: 1), onClose);
    // onClose();
  }

  AsyncSnapshot<FirebaseUser> userSnapshot;
  void onClose() {
    userSnapshot?.data?.uid == null
        ? Navigator.pushReplacementNamed(context, '/welcome')
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ReusableLogo(),
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
