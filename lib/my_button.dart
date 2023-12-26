import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final Color bgColor;

  const MyButton({super.key, required this.fontSize, required this.text, required this.color, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(45)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Text(text, style: TextStyle(fontSize: fontSize, color: color)),
          ),
        ));
    ;
  }
}
