import 'package:flutter/material.dart';
import 'package:Shravik/constants/globals.dart';
import 'package:Shravik/services/language_provider.dart';
import 'package:Shravik/ui/components/reusablelogo.dart';
import 'package:Shravik/ui/share.dart';
import 'package:provider/provider.dart';
import '../localizations.dart';
import 'components/dropdown_picker.dart';
import 'components/gradientbutton.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return SafeArea(
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              shareIcon(Icon(Icons.share)),
              IconButton(
                icon: Icon(Icons.info),
                onPressed: () {
                  Navigator.pushNamed(context, '/info');
                },
                iconSize: 35,
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Hero(
                  tag: 'reusable-widget',
                  child: ReusableLogo(),
                ),
              ),
              Text(
                labels.auth.welcometitle,
                style: TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                labels.auth.welcometitlefoot,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(labels.settings.language),
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
                ),
                RaisedGradientButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signin');
                  },
                  child: Text(
                    labels.auth.signInButton.toUpperCase(),
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  height: 60,
                  gradient: LinearGradient(
                    colors: [Colors.blue[800], Colors.blue[500]],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedGradientButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/category');
                  },
                  child: Text(
                    labels.auth.signUpButton.toUpperCase(),
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  height: 60,
                  gradient: LinearGradient(
                    colors: [Colors.green[800], Colors.green[500]],
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
