import 'package:flutter/material.dart';
import 'package:Shravik/ui/searchfilters.dart';
import '../localizations.dart';
import 'components/gradientbutton.dart';

class WhoAreU extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(),
        Container(
          child: Center(
            child: Text(
              labels.auth.whichUser,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedGradientButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchFilters(category: 'Worker'),
                    ),
                  );
                },
                child: Text(
                  labels.auth.radio1,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchFilters(category: 'Employer'),
                    ),
                  );
                },
                child: Text(
                  labels.auth.radio2,
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
    );
  }
}
