import 'package:flutter/material.dart';

import 'Styles.dart';

class Button extends StatelessWidget {
  final String textButton;
  Function function;

  Button({super.key, required this.textButton, required this.function});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
            child: Text(
          textButton,
          style: (Styles.textStyleTitle20)
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
