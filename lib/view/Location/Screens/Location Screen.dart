import 'package:MBAG/view/Location/Screens/NearestBranch.dart';
import 'package:MBAG/view/on_bording_screen/Widget/buttom_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Core/widgets/Styles.dart';
import '../Controller/Location_Controller.dart';

class LocationScreen extends StatelessWidget {
  final LocationController controller = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 40.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: ImageIcon(AssetImage('Assets/images/Group.png'))),
                Text(
                  'M',
                  style: Styles.textStyleTitle24
                      .copyWith(fontSize: 40, fontStyle: FontStyle.normal),
                ),
                ImageIcon(
                  AssetImage('Assets/images/exclamation.png'),
                  size: 20,
                )
              ],
            ),
            SizedBox(
              height: 40.h,
            ),
            Center(
              child: Text(
                'Add your location',
                style: Styles.textStyleTitle24,
              ),
            ),
            SizedBox(
                width: 370.h,
                child: Text(
                  ' Please add the location that you want clients contact you in it',
                  style: Styles.textStyleTitle16.copyWith(
                    color: Color(0Xff6A6969),
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                )),
            SizedBox(
              height: 40.h,
            ),
            SizedBox(
              height: 40.h,
            ),
            SizedBox(
              height: 180,
              child: GetBuilder<LocationController>(
                builder: (controller) {
                  Position? _currentPosition = controller.currentPosition.value;

                  return _currentPosition == null
                      ? Center(
                          child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white),
                          ),
                        ))
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: GoogleMap(
                            mapType: MapType.normal,
                            zoomControlsEnabled: true,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                _currentPosition.latitude,
                                _currentPosition.longitude,
                              ),
                              zoom: 15,
                            ),
                            onMapCreated: (GoogleMapController controller) {},
                            markers: {
                              Marker(
                                markerId: MarkerId('current_location'),
                                position: LatLng(
                                  _currentPosition.latitude,
                                  _currentPosition.longitude,
                                ),
                                infoWindow:
                                    InfoWindow(title: 'Current Location'),
                              ),
                            },
                          ),
                        );
                },
              ),
            ),
            Spacer(),
            Buttoms(
                text: 'Nearest Branch',
                color: Colors.black,
                onPressed: () {
                  Get.to(() => NearestBranch());
                },
                colorText: Colors.white)
          ],
        ),
      ),
    );
  }
}
