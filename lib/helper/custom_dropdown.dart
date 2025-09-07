import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  CustomDropdownField({
    super.key,
    required this.items,
    required this.labelText,
    this.onChanged,
    this.value,
    this.onSaved,
    this.isEnabled = true,
    this.validator,
    this.menuMaxHeight = 250,
    this.hinteText,
  });
  final double menuMaxHeight;
  final List<String> items;
  final bool isEnabled;
  final String? value;
  final String labelText;
  final String? hinteText;
  final Function(String?)? onChanged;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      menuMaxHeight: menuMaxHeight,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
      dropdownColor: Colors.grey,
      onSaved: onSaved,

      validator: (data) {
        if (data?.isEmpty ?? true) {
          return 'Field is required';
        }
        if (validator != null) {
          return validator!(data);
        }

        return null;
      },
      value: value,
      items: items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: TextStyle(color: Colors.black)),
            ),
          )
          .toList(),
      onChanged: isEnabled ? onChanged : null,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black),
        hintText: hinteText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
