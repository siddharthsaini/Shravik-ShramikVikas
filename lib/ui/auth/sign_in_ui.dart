import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Shravik/localizations.dart';
import 'package:Shravik/ui/components/components.dart';
import 'package:Shravik/helpers/helpers.dart';
import 'package:Shravik/services/services.dart';
import 'package:Shravik/ui/components/reusablelogo.dart';

class SignInUI extends StatefulWidget {
  _SignInUIState createState() => _SignInUIState();
}

class _SignInUIState extends State<SignInUI> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

    return Scaffold(
      key: _scaffoldKey,
      body: LoadingScreen(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Hero(
                          tag: 'reusable-widget',
                          child: ReusableLogo(),
                        ),
                        Text(
                          labels.auth.signInButton,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 48.0),
                    FormInputFieldWithIcon(
                      controller: _email,
                      iconPrefix: Icons.phone,
                      labelText: labels.home.phone,
                      validator: Validator(labels).number,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) => null,
                      onSaved: (value) => _email.text = value,
                    ),
                    FormVerticalSpace(),
                    FormInputFieldWithIcon(
                      controller: _password,
                      iconPrefix: Icons.lock,
                      labelText: labels.auth.passwordFormField,
                      validator: Validator(labels).password,
                      obscureText: true,
                      onChanged: (value) => null,
                      onSaved: (value) => _password.text = value,
                      maxLines: 1,
                    ),
                    FormVerticalSpace(),
                    Container(
                      width: double.infinity,
                      child: PrimaryButton(
                          labelText: labels.auth.signInButton,
                          onPressed: () async {
                            // print(_email.text);
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                _loading = true;
                              });
                              AuthService _auth = AuthService();
                              bool status = await _auth
                                  .signInWithEmailAndPassword(
                                      _email.text + '@shravik.in',
                                      _password.text)
                                  .then((status) {
                                setState(() {
                                  _loading = false;
                                });
                                return status;
                              });
                              if (!status) {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(labels.auth.signInError),
                                ));
                              }
                            }
                          }),
                    ),
                    FormVerticalSpace(),
                    // LabelButton(
                    //   labelText: labels.auth.resetPasswordLabelButton,
                    //   onPressed: () => Navigator.pushReplacementNamed(
                    //       context, '/reset-password'),
                    // ),
                    LabelButton(
                      labelText: labels.auth.signUpLabelButton,
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/category'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        inAsyncCall: _loading,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
