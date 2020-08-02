import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

import '../../localizations.dart';

class JobCheckbox extends StatelessWidget {
  final Function onPress;
  final String title;
  JobCheckbox({this.onPress, this.title});
  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final labels = AppLocalizations.of(context);

    return MultiSelectFormField(
      autovalidate: false,
      titleText: title,
      validator: (value) {
        if (value == null || value.length == 0) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
              backgroundColor: Colors.red[600],
              content: Text(labels.auth.choose1orMore)));
        }
      },
      dataSource: [
        {
          "display": labels.auth.construction,
          "value": "Construction Labourer",
        },
        {
          "display": labels.auth.factory1,
          "value": "Factory Worker - Helper",
        },
        {
          "display": labels.auth.factory2,
          "value": "Factory Worker - Skilled",
        },
        {
          "display": labels.auth.factory3,
          "value": "Factory Worker - Non Skilled",
        },
        {
          "display": labels.auth.maid,
          "value": "Domestic Helper / Maid",
        },
        {
          "display": labels.auth.electrician,
          "value": "Electrician",
        },
        {
          "display": labels.auth.carpenter,
          "value": "Carpenter",
        },
        {
          "display": labels.auth.plumber,
          "value": "Plumber",
        },
        {
          "display": labels.auth.guard,
          "value": "Security Guard",
        },
        {
          "display": labels.auth.driver,
          "value": "Driver",
        },
        {
          "display": labels.auth.supervisor,
          "value": "Supervisor",
        },
        {
          "display": labels.auth.officeBoy,
          "value": "Office Boy",
        },
        {
          "display": labels.auth.tailor,
          "value": "Tailor",
        },
        {
          "display": labels.auth.cook,
          "value": "Cook",
        },
        {
          "display": labels.auth.salesman,
          "value": "Salesman",
        },
        {
          "display": labels.auth.others,
          "value": "Others",
        },
      ],
      textField: 'display',
      valueField: 'value',
      okButtonLabel: labels.auth.ok,
      cancelButtonLabel: labels.auth.cancelBox,
      fillColor: Colors.green,
      required: true,
      hintText: labels.auth.oneorMore,
      // value: _job,
      onSaved: onPress,
      errorText: labels.validator.req,
    );
  }
}
