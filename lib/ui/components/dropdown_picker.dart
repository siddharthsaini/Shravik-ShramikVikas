import 'package:flutter/material.dart';
class DropdownPicker extends StatelessWidget {
  DropdownPicker({this.menuOptions, this.selectedOption, this.onChanged});

  final List<dynamic> menuOptions;
  final String selectedOption;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        items: menuOptions
            .map((data) => DropdownMenuItem<String>(
                  child: Text(
                    data.value,
                  ),
                  value: data.key,
                ))
            .toList(),
        value: selectedOption,
        onChanged: onChanged);
  }
}
