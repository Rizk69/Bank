import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

import '../../../Core/http_helper.dart';
import '../model/NearestBranchMdel.dart';

class LocationController extends GetxController {
  late Rx<Position?> nearestPosition = Rx<Position?>(null);
  late Rx<Position?> currentPosition = Rx<Position?>(null);
  late NearestBranchModel _nearestBranchModel =
      NearestBranchModel(); // Initialize _nearestBranchModel

  NearestBranchModel get nearestBranchModel => _nearestBranchModel;
  var isLoading = true.obs; // Start with loading as true

  @override
  void onInit() async {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentPosition.value = position;
      await addCurrentPosition(); // Use await here if you need to wait for it to complete

      update();
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> addCurrentPosition() async {
    try {
      final response = await HttpHelper.postData(
        endpoint: "add_location_user",
        body: {
          "lat": currentPosition.value?.latitude,
          "long": currentPosition.value?.longitude,
          "place": 'CurrentLocation',
          "address": 'CurrentLocation',
        },
      );
      if (response["status"] == true) {
        isLoading.value = false;
        update();
        fetchDataNearestBranch();
      }
    } catch (e) {
      // Handle errors here
      print('Error: $e');
      isLoading.value = false; // Set loading to false on error
    }
  }

  Future<void> fetchDataNearestBranch() async {
    try {
      final response = await HttpHelper.getData(
        endpoint: "get_branches_user",
      );
      if (response["status"] == true) {
        _nearestBranchModel = NearestBranchModel.fromJson(response);
        nearestPosition.value = Position(
          latitude: nearestBranchModel.nearestBranch?.latitude ?? 0.0,
          longitude: nearestBranchModel.nearestBranch?.longitude ?? 0.0,
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
          timestamp: DateTime.now(), // Provide a valid timestamp
        );
        update();

        print('Status: ${nearestBranchModel.status}');
        print('Message: ${nearestBranchModel.message}');

        if (nearestBranchModel.nearestBranch != null) {
          print('Nearest Branch ID: ${nearestBranchModel.nearestBranch!.id}');
          print(
              'Nearest Branch Name: ${nearestBranchModel.nearestBranch!.name}');
          // Access other properties as needed
        }

        if (nearestBranchModel.nearestBranches != null) {
          print(
              'Number of Nearest Branches: ${nearestBranchModel.nearestBranches!.length}');
          for (var branch in nearestBranchModel.nearestBranches!) {
            print('Branch ID: ${branch.id}');
            print('Branch Name: ${branch.name}');
            // Access other properties as needed
          }
        }
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception.
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle errors here
      print('Error: $e');
    }
  }
}
