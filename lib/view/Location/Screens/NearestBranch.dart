import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../Core/widgets/Styles.dart';
import '../Controller/Location_Controller.dart';

class NearestBranch extends StatelessWidget {
  final LocationController controller = Get.put(LocationController());

  NearestBranch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(19),
          child: GetBuilder<LocationController>(builder: (controller) {
            return controller.isLoading.value
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2.4,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: const SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text('Please Wait...')
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const ImageIcon(
                                  AssetImage('Assets/images/Group.png'))),
                          Text(
                            'M',
                            style: Styles.textStyleTitle24.copyWith(
                                fontSize: 40, fontStyle: FontStyle.normal),
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
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: Offset(
                                    0, 3), // changes the position of the shadow
                              ),
                            ],
                            border: Border.all(width: 0.9, color: Colors.black),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        'Nearest branch',
                                        style: Styles.textStyleTitle20.copyWith(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1, vertical: 5),
                                      height: 140.h,
                                      child: GetBuilder<LocationController>(
                                        builder: (controller) {
                                          Position? _currentPosition =
                                              controller.nearestPosition.value;

                                          return _currentPosition == null
                                              ? Center(child: SizedBox.shrink())
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: GoogleMap(
                                                    mapType: MapType.normal,
                                                    zoomControlsEnabled: true,
                                                    initialCameraPosition:
                                                        CameraPosition(
                                                      target: LatLng(
                                                        _currentPosition
                                                            .latitude,
                                                        _currentPosition
                                                            .longitude,
                                                      ),
                                                      zoom: 15,
                                                    ),
                                                    onMapCreated:
                                                        (GoogleMapController
                                                            controller) {},
                                                    markers: {
                                                      Marker(
                                                        markerId: MarkerId(
                                                            'current_location'),
                                                        position: LatLng(
                                                          _currentPosition
                                                              .latitude,
                                                          _currentPosition
                                                              .longitude,
                                                        ),
                                                        infoWindow: InfoWindow(
                                                            title:
                                                                'Current Location'),
                                                      ),
                                                    },
                                                  ),
                                                );
                                        },
                                      ),
                                    ),
                                    Text(
                                      controller.nearestBranchModel
                                              ?.nearestBranch?.title ??
                                          '',
                                      style: Styles.textStyleTitle20.copyWith(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      controller.nearestBranchModel
                                              ?.nearestBranch?.name ??
                                          '',
                                      style: Styles.textStyleTitle12.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Color(0Xff6A6969),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                child: Text(
                                  '+ Add delivery instruction',
                                  style: Styles.textStyleTitle20
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Text(
                        'Branches',
                        style: Styles.textStyleTitle18.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      SizedBox(
                        height: 250.h,
                        child: ListView.builder(
                          itemCount: controller
                                  .nearestBranchModel.nearestBranches?.length ??
                              0,
                          itemBuilder: (context, index) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              height: 85.h,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 0.8),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.nearestBranchModel
                                            .nearestBranches?[index].title ??
                                        '',
                                    style: Styles.textStyleTitle20
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                      controller.nearestBranchModel
                                              .nearestBranches?[index].name ??
                                          '',
                                      style: Styles.textStyleTitle16.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Color(0XFF6A6969))),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  );
          }),
        ),
      ),
    );
  }
}
