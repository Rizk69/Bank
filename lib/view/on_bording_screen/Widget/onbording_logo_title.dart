import 'package:flutter/material.dart';

class OnBordingLogoAndTitle extends StatelessWidget {
  const OnBordingLogoAndTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'Assets/images/Logo Mbag without background.png',
          height: 200,
        ),
        const Positioned(
          bottom: 0,
          child: Text(
            'Send money for free, at \n\t\t\t\t\t\t lightning speed.',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
