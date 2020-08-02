import 'package:flutter/material.dart';
import 'package:Shravik/ui/components/components.dart';
import 'package:Shravik/services/services.dart';
import 'package:Shravik/ui/components/reusablelogo.dart';

class SignInOptionsUI extends StatefulWidget {
  createState() => SignInOptionsUIState();
}

class SignInOptionsUIState extends State<SignInOptionsUI> {
  AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();
    auth.getUser.then(
      (user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/topics');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ReusableLogo(),
              SizedBox(height: 48.0),
              FormVerticalSpace(),
              PrimaryButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, '/signin');
                  },
                  labelText: 'Sign In with Email & Password'),
              FormVerticalSpace(),
            ],
          ),
        ),
      ),
    );
  }
}
