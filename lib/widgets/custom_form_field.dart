import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final Function(String) onSaved;
  final String regEx;
  final String hintText;
  final bool obscureText;

  const CustomFormField({super.key, required this.onSaved, required this.regEx, required this.hintText, required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.black45,
        filled: true,
          border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
      ),
        hintText: hintText,
        hintStyle: TextStyle(color:
        Colors.white54)
      ),
      onSaved: (_value)=>onSaved(_value!),
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      obscureText: obscureText,
      validator: (_value){
        return RegExp(regEx).hasMatch(_value!)?null:"Enter a valid value";
      },
    );
  }
}
