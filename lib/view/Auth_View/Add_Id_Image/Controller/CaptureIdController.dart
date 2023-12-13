// import 'package:get/get.dart';
// import 'package:camera/camera.dart';
//
// class CaptureIdController extends GetxController {
//   late CameraController cameraController;
//   late XFile capturedImage;
//
//   // Initialize the camera controller in the constructor
//   CaptureIdController() {
//     initializeCamera();
//   }
//
//   // Function to initialize the camera controller
//   Future<void> initializeCamera() async {
//     final cameras = await availableCameras();
//     cameraController = CameraController(cameras[0], ResolutionPreset.medium);
//     await cameraController.initialize();
//     update(); // Notify listeners about the change
//   }
//
//   // Function to take a picture
//   Future<void> takePicture() async {
//     try {
//       // Ensure the controller is initialized
//       if (!cameraController.value.isInitialized) {
//         return;
//       }
//
//       // Take the picture
//       final XFile file = await cameraController.takePicture();
//
//       // Update the captured image and notify listeners
//       capturedImage = file;
//       update();
//     } catch (e) {
//       print('Error taking picture: $e');
//     }
//   }
//
//   // Function to detect ID card using TFLite
//   // Future<void> detectIdCard() async {
//   //   try {
//   //     final List? recognitions = await Tflite.runModelOnImage(
//   //       path: capturedImage.path,
//   //       numResults: 2,
//   //       threshold: 0.5,
//   //       imageMean: 127.5,
//   //       imageStd: 127.5,
//   //     );
//   //
//   //     // Rest of the detection logic...
//   //   } catch (e) {
//   //     print('Error detecting ID card: $e');
//   //   }
//   // }
// }
