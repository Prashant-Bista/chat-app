import 'package:flutter/material.dart';

class InputFields extends StatefulWidget {
  final String hintText;
  final Icon prefixIcon;
  final validator;
  final bool isobscured;
  final TextEditingController controller;
  final double width;
  const InputFields({super.key, required this.hintText, required this.prefixIcon,  required this.controller, required this.width, @required this.validator, required this.isobscured});

  @override
  State<InputFields> createState() => _InputFieldsState();
}

class _InputFieldsState extends State<InputFields> {
  bool makeInvisible=true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 1,right: 1,left: 1),
      width: widget.width/1.5,
      height: 50.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromRGBO(30, 41, 53, 1)
      ),
      child: TextFormField(
        obscureText: widget.isobscured?makeInvisible:false,
        style: const TextStyle(color: Colors.white),
        validator: widget.validator,
        controller: widget.controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          suffixIcon:widget.isobscured?IconButton(onPressed: (){
            setState(() {
              makeInvisible=!makeInvisible;
            });}, icon: const Icon(Icons.remove_red_eye,color: Colors.grey,size: 20,)):null,
          hintStyle: const TextStyle(color: Colors.grey),
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                  color: Color.fromRGBO(30, 41, 53, 1),
                  width: 1,
                  style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                  color: Color.fromRGBO(30, 41, 53, 1),
                  width: 1,
                  style: BorderStyle.solid)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1,
                  style: BorderStyle.solid)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 1,
                  style: BorderStyle.solid)),
        ),
      ),
    );
  }
}

class LargeButton extends StatefulWidget {
  final formKey;
  final String name;
  final onPressed;
  const LargeButton({super.key, @required this.formKey, required this.name, @required this.onPressed});

  @override
  State<LargeButton> createState() => _LargeButtonState();
}

class _LargeButtonState extends State<LargeButton> {
  @override
  Widget build(BuildContext context) {
    double heightDevice = MediaQuery.of(context).size.height;
    double widthDevice = MediaQuery.of(context).size.width;
    return MaterialButton(
      height: heightDevice/15,
      minWidth: widthDevice / 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      color: Colors.deepPurple,
      splashColor: Colors.deepPurpleAccent,
      onPressed: widget.onPressed,
      padding: EdgeInsets.zero,
      child: Text(
        widget.name,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}

