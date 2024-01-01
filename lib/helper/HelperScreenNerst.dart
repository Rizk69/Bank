import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SlideDownTextAnimation extends StatefulWidget {
  bool appBarView = false;

  @override
  SlideDownTextAnimation({required this.appBarView});

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
          MediaQuery.of(context).size.height / 1.9 - 8.0; // Adjust as needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBarView
          ? AppBar(
              centerTitle: true,
              title: const ImageIcon(
                AssetImage('Assets/images/M black.png'),
                size: 50,
              ),
            )
          : AppBar(
              leading: SizedBox(),
            ),
      body: Stack(
        children: [
          // Your main content goes here
          Center(child: Image.asset('Assets/images/MBAG.png', height: 80.h)),
          // Animated sliding text
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
            top: _position,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.orangeAccent,
              child: Center(
                child: Text(
                  'Coming Soon',
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
