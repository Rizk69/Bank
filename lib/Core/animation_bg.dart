// import 'package:animated_background/animated_background.dart';
// import 'package:flutter/material.dart';
//
// class MyAnimatedBackground extends StatefulWidget {
//   // final Image img;
//   final String path1;
//   final String path2;
//
//   // final Image img2;
//   const MyAnimatedBackground({
//     Key? key,
//     required this.path1,
//     required this.path2,
//   }) : super(key: key);
//
//   @override
//   State<MyAnimatedBackground> createState() => _MyAnimatedBackgroundState();
// }
//
// class _MyAnimatedBackgroundState extends State<MyAnimatedBackground>
//     with TickerProviderStateMixin {
//   late AnimationController animationController;
//
//   @override
//   void initState() {
//     super.initState();
//     animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(minutes: 10),
//     );
//
//     animationController.repeat();
//   }
//
//   @override
//   void dispose() {
//     animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final imagePath = widget.path1;
//     final imagePath2 = widget.path2;
//     // return MaterialApp
//     return Positioned.fill(
//       child: Stack(
//         children: [
//           AnimatedBuilder(
//             animation: animationController,
//             builder: (BuildContext context, Widget? widget) {
//               return Transform.rotate(
//                 angle: animationController.value * -20,
//                 child: widget,
//               );
//             },
//             child: AnimatedBackground(
//               // vsync uses singleTicketProvider state mixin.
//               vsync: this,
//               behaviour: RandomParticleBehaviour(
//                 options: ParticleOptions(
//                   image: Image.asset(imagePath),
//                   spawnOpacity: 0.0,
//                   opacityChangeRate: 0.1,
//                   minOpacity: 0.8,
//                   maxOpacity: 0.9,
//                   particleCount: 5,
//                   spawnMaxRadius: 25,
//                   spawnMinRadius: 9,
//                   spawnMaxSpeed: 30,
//                   spawnMinSpeed: 10,
//                 ),
//               ),
//               child: const Center(
//                   child: Text(
//                 // center text
//                 "",
//                 style: TextStyle(fontSize: 50),
//               )),
//             ),
//           ),
//           AnimatedBuilder(
//             animation: animationController,
//             builder: (BuildContext context, Widget? widget) {
//               return Transform.rotate(
//                 angle: animationController.value * 80,
//                 child: widget,
//               );
//             },
//             child: AnimatedBackground(
//               // vsync uses singleTicketProvider state mixin.
//               vsync: this,
//               behaviour: RandomParticleBehaviour(
//                 options: ParticleOptions(
//                   image: Image.asset(imagePath),
//                   spawnOpacity: 0.0,
//                   opacityChangeRate: 0.1,
//                   minOpacity: 0.8,
//                   maxOpacity: 0.9,
//                   particleCount: 5,
//                   spawnMaxRadius: 25,
//                   spawnMinRadius: 9,
//                   spawnMaxSpeed: 30,
//                   spawnMinSpeed: 10,
//                 ),
//               ),
//               child: const Center(
//                   child: Text(
//                 // center text
//                 "",
//                 style: TextStyle(fontSize: 50),
//               )),
//             ),
//           ),
//           AnimatedBuilder(
//             animation: animationController,
//             builder: (BuildContext context, Widget? widget) {
//               return Transform.rotate(
//                 angle: animationController.value * 50,
//                 child: widget,
//               );
//             },
//             child: AnimatedBackground(
//               // vsync uses singleTicketProvider state mixin.
//               vsync: this,
//               behaviour: RandomParticleBehaviour(
//                 options: ParticleOptions(
//                   image: Image.asset(imagePath2),
//                   spawnOpacity: 0.0,
//                   opacityChangeRate: 0.1,
//                   minOpacity: 0.8,
//                   maxOpacity: 0.9,
//                   particleCount: 5,
//                   spawnMaxRadius: 25,
//                   spawnMinRadius: 9,
//                   spawnMaxSpeed: 30,
//                   spawnMinSpeed: 10,
//                 ),
//               ),
//               child: const Center(
//                   child: Text(
//                 // center text
//                 "",
//                 style: TextStyle(fontSize: 50),
//               )),
//             ),
//           ),
//           AnimatedBuilder(
//             animation: animationController,
//             builder: (BuildContext context, Widget? widget) {
//               return Transform.rotate(
//                 angle: animationController.value * -50,
//                 child: widget,
//               );
//             },
//             child: AnimatedBackground(
//               // vsync uses singleTicketProvider state mixin.
//               vsync: this,
//               behaviour: RandomParticleBehaviour(
//                 options: ParticleOptions(
//                   image: Image.asset(imagePath2),
//                   spawnOpacity: 0.0,
//                   opacityChangeRate: 0.1,
//                   minOpacity: 0.8,
//                   maxOpacity: 0.9,
//                   particleCount: 5,
//                   spawnMaxRadius: 25,
//                   spawnMinRadius: 9,
//                   spawnMaxSpeed: 30,
//                   spawnMinSpeed: 10,
//                 ),
//               ),
//               child: const Center(
//                   child: Text(
//                 // center text
//                 "",
//                 style: TextStyle(fontSize: 50),
//               )),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
