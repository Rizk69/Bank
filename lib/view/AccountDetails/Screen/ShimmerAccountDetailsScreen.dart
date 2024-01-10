import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerAccountDetailsScreen extends StatelessWidget {
  const ShimmerAccountDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              // ...ShimmerAccountDetailsScreen
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 70.h,
                  width: double.infinity,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 70.h,
                  width: double.infinity,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 70.h,
                  width: double.infinity,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 70.h,
                  width: double.infinity,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 70.h,
                  width: double.infinity,
                ),
              ),

              // ...
            ],
          ),
        ),
      ),
    );
  }
}
