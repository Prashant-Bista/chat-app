import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final Function(String) onSaved;
  final String regEx;
  final String hintText;
  final bool obscureText;

  const CustomFormField({
    super.key,
    required this.onSaved,
    required this.regEx,
    required this.hintText,
    required this.obscureText,
  });

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
        hintStyle: TextStyle(color: Colors.white54),
      ),
      onSaved: (String? _value) => onSaved(_value!),
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      obscureText: obscureText,
      validator: (_value) {
        if (_value == null || _value.isEmpty) {
          return 'This field cannot be empty';
        }
        if (!RegExp(regEx).hasMatch(_value)) {
          return 'Enter a valid value';
        }
        return null;
      },
    );
  }
}
class CustomTextField extends StatelessWidget {
  final Function(String) onEditingComplete;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  IconData? icon;
   CustomTextField({super.key,required this.onEditingComplete ,required this.hintText,required this.obscureText,required this.controller,this.icon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onEditingComplete: ()=>onEditingComplete(controller.value.text),
      cursorColor: Colors.white,
      style: TextStyle(
        color: Colors.white,

      ),
      obscureText: obscureText,

decoration: InputDecoration(
  fillColor: Color.fromRGBO(30, 30, 35, 1.0),
  filled: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide.none
  ),
  hintText: hintText,
  hintStyle: TextStyle(color: Colors.white54),
    prefixIcon: Icon(icon,color: Colors.white54,),
),
    );
  }
}

