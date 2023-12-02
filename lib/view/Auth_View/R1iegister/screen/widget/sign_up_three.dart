import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../../../../../Core/widgets/Button.dart';
import '../../../../../Core/widgets/Navigation/navigation.dart';
import '../../../../../Core/widgets/Styles.dart';
import '../../controllers/register_controller.dart';
import '../../cubit/register_cubit.dart';
import '../../cubit/register_state.dart';

class SignUpThree extends StatelessWidget {
  SignUpThree({super.key});

  var registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Upload your Id',
                  style: Styles.textStyleTitle18,
                )),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  registerController.showAlert(
                    context: context,
                    camera: () {
                      BlocProvider.of<RegisterCubit>(context)
                          .getFrontIdImage(isCamera: true);
                      navigapop(context);
                    },
                    gallary: () {
                      BlocProvider.of<RegisterCubit>(context)
                          .getFrontIdImage(isCamera: false);
                      navigapop(context);
                    },
                  );

                  print(BlocProvider.of<RegisterCubit>(context).FrontId);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: const Color(0xffEEBB49),
                      width: 1.0,
                    ),
                  ),
                  child: Center(
                    child: (BlocProvider.of<RegisterCubit>(context).FrontId ==
                            null)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.cloud_upload_rounded,
                                color: Color(0xffEEBB49),
                              ),
                              Text(
                                'click hear to upload face id',
                                style: Styles.textStyleTitle16,
                              ),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 4),
                            child: Image.file(
                              BlocProvider.of<RegisterCubit>(context).FrontId!,
                              fit: BoxFit.fill,
                              width: double.infinity,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  registerController.showAlert(
                    context: context,
                    camera: () {
                      BlocProvider.of<RegisterCubit>(context)
                          .getBackIdImage(isCamera: true);
                      navigapop(context);
                    },
                    gallary: () {
                      BlocProvider.of<RegisterCubit>(context)
                          .getBackIdImage(isCamera: false);
                      navigapop(context);
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: Color(0xffEEBB49), // لون الحاف
                      width: 1.0, // عرض الحاف
                    ),
                  ),
                  child: Center(
                      child: (BlocProvider.of<RegisterCubit>(context).BackId ==
                              null)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cloud_upload_rounded,
                                  color: Color(0xffEEBB49),
                                ),
                                Text(
                                  'click hear to upload back id',
                                  style: Styles.textStyleTitle16,
                                )
                              ],
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 4),
                              child: Image.file(
                                BlocProvider.of<RegisterCubit>(context).BackId!,
                                fit: BoxFit.fill,
                                width: double.infinity,
                              ),
                            )),
                ),
              ),
            ),
            // SizedBox(
            //   height: 20.h,
            // ),
            // Button(
            //   textButton: "Skip",
            //   function: () {
            //     if (BlocProvider.of<RegisterCubit>(context).FrontId == null ||
            //         BlocProvider.of<RegisterCubit>(context).BackId == null) {
            //       Get.snackbar("Warning!", "Please Enter Required Fields");
            //     } else {
            //       registerController.navig();
            //     }
            //   },
            // )
          ],
        );
      },
    );
  }
}
