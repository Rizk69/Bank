import 'package:MBAG/Core/widgets/Styles.dart';
import 'package:flutter/material.dart';

class SlideDownTextAnimation extends StatefulWidget {
  const SlideDownTextAnimation({super.key});

  @override
  _SlideDownTextAnimationState createState() => _SlideDownTextAnimationState();
}

class _SlideDownTextAnimationState extends State<SlideDownTextAnimation> {
  double _position = -100.0; // Initial position above the screen

  @override
  void initState() {
    super.initState();
    // Trigger animation on widget creation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAnimation();
    });
  }

  void _startAnimation() {
    // Animate the position to the middle of the screen
    setState(() {
      _position =
          MediaQuery.of(context).size.height / 2 - 50.0; // Adjust as needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          // Your main content goes here
          Center(
            child: Text(
              'MBAGE',
              style: Styles.textStyleTitle24,
            ),
          ),
          // Animated sliding text
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            curve: Curves.fastEaseInToSlowEaseOut,
            top: _position,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.indigoAccent,
              child: Center(
                child: Text(
                  'قريبا',
                  style: Styles.textStyleTitle24.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
