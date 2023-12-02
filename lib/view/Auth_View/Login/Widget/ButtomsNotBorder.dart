import 'package:flutter/material.dart';

class ButtomsNotBorder extends StatelessWidget {
  String text;
  Color color;
  Color colorText;
  final VoidCallback onPressed;

  ButtomsNotBorder(
      {required this.text,
      required this.color,
      required this.onPressed,
      required this.colorText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(color),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(12),
        child: Text(
          text,
          style: TextStyle(
            color: colorText,
            fontFamily: 'Roboto',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
