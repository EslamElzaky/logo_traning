import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormTextField extends StatefulWidget {
  CustomFormTextField({
    super.key,
    this.prefixText,
    this.readOnly = false,
    this.maxLines = 1,
    this.labelText,
    this.keyboardType,
    this.hintText,
    this.onChanged,
    this.obscureText = false,
    this.controller,

    this.usePassword = false,
    this.onSaved,
    this.initialValue,
    this.validator,
    this.maxLength,
    this.inputFormatters,
    this.errorText,
  });

  final bool usePassword;
  final String? hintText;
  final String? initialValue;
  final int maxLines;
  final int? maxLength;
  final String? labelText;
  final String? prefixText;
  final String? errorText;

  final TextInputType? keyboardType;
  bool obscureText;
  final Function(String)? onChanged;
  final TextEditingController? controller;

  final bool readOnly;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<CustomFormTextField> createState() => _CustomFormTextFieldState();
}

class _CustomFormTextFieldState extends State<CustomFormTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(color: Colors.black),
      inputFormatters: widget.inputFormatters,
      maxLength: widget.maxLength,
      initialValue: widget.initialValue,
      onSaved: widget.onSaved,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      cursorColor: Colors.black,
      obscureText: widget.obscureText,
      readOnly: widget.readOnly,

      onChanged: widget.onChanged,

      validator: (data) {
        if (data?.isEmpty ?? true) {
          
          return 'Field is required';
        } 
        if (widget.validator != null) {
          return widget.validator!(data);
        }

        return null;
      },

      decoration: InputDecoration(
        errorText: widget.errorText,
        prefixText: widget.prefixText,
        labelText: widget.labelText,
        labelStyle: TextStyle(color: Colors.black, fontSize: 22),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: widget.hintText,
        suffixIcon: widget.usePassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    widget.obscureText = !widget.obscureText;
                  });
                },
                child: Icon(
                  widget.obscureText
                      ? Icons.visibility_off
                      : Icons.remove_red_eye,
                  color: Colors.black,
                ),
              )
            : const SizedBox.shrink(),

        hintStyle: const TextStyle(color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
