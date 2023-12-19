import 'package:bank/Core/widgets/Styles.dart';
import 'package:bank/view/Home_View/Screens/home_screen.dart';
import 'package:bank/view/on_bording_screen/Widget/buttom_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ScreenSuccessfull extends StatelessWidget {
  const ScreenSuccessfull({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
            ),
            Center(child: AnimatedCheck()),
            SizedBox(
              height: 15.h,
            ),
            Center(
                child: Text('The transaction has been',
                    style: Styles.textStyleTitle24)),
            Center(child: Text('successful.', style: Styles.textStyleTitle24)),
            SizedBox(
              height: 15.h,
            ),
            Center(
                child: Text(
              'Your money transfer has been successful.',
              style: Styles.textStyleTitle16.copyWith(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            )),
            SizedBox(
              height: 30.h,
            ),
            Center(
                child: Text(
              'You can perform this transaction automatically',
              style: Styles.textStyleTitle16.copyWith(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            )),
            Center(
                child: Text(
              'by giving aRecurring Transfer Order.',
              style: Styles.textStyleTitle16.copyWith(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            )),
            Spacer(),
            Buttoms(
                text: 'Receipt',
                color: Colors.white,
                onPressed: () {},
                colorText: Colors.black),
            SizedBox(
              height: 15.h,
            ),
            Buttoms(
                text: 'Set Up Recurring Transfer',
                color: Colors.white,
                onPressed: () {},
                colorText: Colors.black),
            SizedBox(
              height: 15.h,
            ),
            Buttoms(
                text: 'Ok',
                color: Colors.black,
                onPressed: () {
                  Get.offAll(() => HomeScreen());
                },
                colorText: Colors.white),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedCheck extends StatefulWidget {
  @override
  _AnimatedCheckState createState() => _AnimatedCheckState();
}

class _AnimatedCheckState extends State<AnimatedCheck>
    with TickerProviderStateMixin {
  late AnimationController scaleController =
      AnimationController(duration: const Duration(seconds: 2), vsync: this);
  late Animation<double> scaleAnimation =
      CurvedAnimation(parent: scaleController, curve: Curves.elasticOut);
  late AnimationController checkController =
      AnimationController(duration: const Duration(seconds: 1), vsync: this);
  late Animation<double> checkAnimation =
      CurvedAnimation(parent: checkController, curve: Curves.linear);

  @override
  void initState() {
    super.initState();
    scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkController.forward();
      }
    });
    scaleController.forward();
  }

  @override
  void dispose() {
    scaleController.dispose();
    checkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double circleSize = 80;
    double iconSize = 55;

    return ScaleTransition(
      scale: scaleAnimation,
      child: Container(
        height: circleSize,
        width: circleSize,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.green, width: 7)),
        child: SizeTransition(
            sizeFactor: checkAnimation,
            axis: Axis.horizontal,
            axisAlignment: -1,
            child: Center(
                child: Icon(
              Icons.check,
              color: Colors.green,
              size: iconSize,
            ))),
      ),
    );
  }
}
