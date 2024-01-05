import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../Core/widgets/Styles.dart';

class TraderAdressScreen extends StatelessWidget {
  double lat;
  double long;

  TraderAdressScreen({required this.lat, required this.long});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 60.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30,
                  )),
              Text(
                'Trader Address',
                style: Styles.textStyleTitle24
                    .copyWith(fontSize: 25, fontStyle: FontStyle.normal),
              ),
              SizedBox(
                width: 20,
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 4.98,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: GoogleMap(
                  mapType: MapType.normal,
                  zoomControlsEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      lat,
                      long,
                    ),
                    zoom: 8,
                  ),
                  onMapCreated: (GoogleMapController controller) {},
                  markers: {
                    Marker(
                      markerId: MarkerId('Agent_location'),
                      position: LatLng(lat, long),
                      infoWindow: InfoWindow(title: 'Agent Location'),
                    ),
                  },
                ),
              )),
        ],
      ),
    );
  }
}
