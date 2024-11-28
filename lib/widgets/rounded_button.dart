import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String name;
  final double height;
  final double width;
  final Function onpressed;
  const RoundedButton(
      {super.key,
      required this.name,
      required this.height,
      required this.width,
      required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(height*0.25)
      ),
      height: height,
      width: width,
      child: TextButton(
          onPressed:(){
            onpressed();
          },
          child: Text(
            name,
            style: TextStyle(fontSize: 22, color: Colors.white, height: 1.5),
          )),
    );
  }
}
