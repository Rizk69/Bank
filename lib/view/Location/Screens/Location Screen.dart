import 'package:bank/Core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../Core/widgets/Styles.dart';
import '../Controller/Location_Controller.dart';

class LocationScreen extends StatelessWidget {
  final LocationController controller = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(19),
          child: Column(
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
              Text(
                'Add your location',
                style: Styles.textStyleTitle24,
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
              CustomTextFormField(hintText: 'Type your address '),
              SizedBox(
                height: 40.h,
              ),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.red, size: 30),
                  Text(
                    'Set on map',
                    style: Styles.textStyleTitle20
                        .copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              SizedBox(
                height: 180,
                child: GetBuilder<LocationController>(
                  builder: (controller) {
                    Position? _currentPosition =
                        controller.currentPosition.value;

                    return _currentPosition == null
                        ? Center(child: SizedBox.shrink())
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
              Text(
                'The location you added ',
                style: Styles.textStyleTitle16
                    .copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.start,
              )
            ],
          ),
        ),
      ),
    );
  }
}
