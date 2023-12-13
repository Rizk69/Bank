import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtomsNotBorder extends StatelessWidget {
  String text;
  RxBool isFormValid;
  Color color;
  Color colorText;
  BuildContext context;
  final VoidCallback onPressed;

  ButtomsNotBorder({
    required this.text,
    required this.isFormValid,
    required this.context,
    required this.color,
    required this.onPressed,
    required this.colorText,
  });

  @override
  Widget build(context) {
    return Obx(
      () {
        print("isFormValid: ${isFormValid.value}");
        return ElevatedButton(
          onPressed: isFormValid.value ? onPressed : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              isFormValid.value ? color : Color(0XFFD9D9D9),
            ),
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
      },
    );
  }
}
