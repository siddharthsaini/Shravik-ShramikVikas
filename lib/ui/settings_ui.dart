import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Shravik/ui/components/segmented_selector.dart';
import 'package:Shravik/ui/infocards.dart';
import 'package:Shravik/ui/share.dart';
import 'package:provider/provider.dart';
import 'package:Shravik/localizations.dart';
import 'package:Shravik/services/services.dart';
import 'package:Shravik/ui/components/components.dart';
import 'package:Shravik/models/models.dart';
import 'package:Shravik/constants/constants.dart';

class SettingsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(labels.settings.title),
      ),
      body: _buildLayoutSection(context),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          shareIcon(Icon(
            Icons.share,
            size: 35,
          )),
          bottomMe(
            Text(
              "Developed by Siddharth Saini",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLayoutSection(BuildContext context) {
    final labels = AppLocalizations.of(context);
    final List<MenuOptionsModel> themeOptions = [
      MenuOptionsModel(
          key: "system",
          value: labels.settings.system,
          icon: Icons.brightness_4),
      MenuOptionsModel(
          key: "light",
          value: labels.settings.light,
          icon: Icons.brightness_low),
      MenuOptionsModel(
          key: "dark", value: labels.settings.dark, icon: Icons.brightness_3)
    ];
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text(labels.settings.language),
          trailing: DropdownPicker(
            menuOptions: Globals.languageOptions,
            selectedOption:
                Provider.of<LanguageProvider>(context).currentLanguage,
            onChanged: (value) {
              Provider.of<LanguageProvider>(context, listen: false)
                  .updateLanguage(value);
            },
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                labels.settings.theme,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SegmentedSelector(
                selectedOption: Provider.of<ThemeProvider>(context).getTheme,
                menuOptions: themeOptions,
                onValueChanged: (value) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .updateTheme(value);
                },
              ),
            ),
          ],
        ),
        ListTile(
            title: Text(labels.settings.signOut),
            trailing: RaisedButton(
              onPressed: () {
                AuthService _auth = AuthService();
                _auth.signOut();
              },
              child: Text(
                labels.settings.signOut,
              ),
            ))
      ],
    );
  }
}
