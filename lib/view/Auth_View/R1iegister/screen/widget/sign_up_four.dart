import 'package:bank/view/Auth_View/R1iegister/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';

import '../../../../../Core/widgets/Navigation/navigation.dart';
import '../../../../../Core/widgets/Styles.dart';
import '../../cubit/register_cubit.dart';
import '../../cubit/register_state.dart';

class SignUpFour extends StatelessWidget {
  SignUpFour({super.key});

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
                  'your image',
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
                          .getPostImageByCamera(isCamera: true);
                      navigapop(context);
                    },
                    gallary: () {
                      BlocProvider.of<RegisterCubit>(context)
                          .getPostImageByCamera(isCamera: false);
                      navigapop(context);
                    },
                  );
                },
                child: Container(
                  child: Center(
                    child: (BlocProvider.of<RegisterCubit>(context).Image ==
                            null)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.cloud_upload_rounded,
                                color: Color(0xffEEBB49),
                              ),
                              Text(
                                'click hear to upload Your Image',
                                style: Styles.textStyleTitle16,
                              ),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 4),
                            child: Image.file(
                              BlocProvider.of<RegisterCubit>(context).Image!,
                              fit: BoxFit.fill,
                              width: double.infinity,
                            ),
                          ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: Color(0xffEEBB49), // لون الحاف
                      width: 1.0, // عرض الحاف
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }
}
