import 'package:flutter/material.dart';

class Buttoms extends StatelessWidget {
  String text;
  Color color;
  Color colorText;
  final VoidCallback onPressed;

  Buttoms(
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
            side: BorderSide(color: Colors.black),
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(12),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
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
