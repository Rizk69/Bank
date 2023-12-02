import 'dart:io';

import 'package:bank/view/Auth_View/R1iegister/cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screen/sign_up_screen.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(IntializeRegisterState());

  void registerUser({
    required String email,
    required String password,
    required String password_confirmation,
    required String first_name,
    required String last_name,
    required String id_number,
    required String country_id,
    required String phone,
    required String img,
    required String front_id,
    required String back_id,
  }) {
    print(
        "$email : $password : $password_confirmation : $first_name : $last_name : $id_number : $country_id : $phone : $img : $front_id : $back_id");
    // emit(RegisterViewStateLoading());
    // DioHelper.postData(url: 'register', body: {
    //   'email': email,
    //   'password': password,
    //   'password_confirmation': password_confirmation,
    //   'first_name': first_name,
    //   'last_name': last_name,
    //   'id_number': id_number,
    //   'country_id': country_id,
    //   'phone': phone,
    //   'img': img,
    //   'frout_id': front_id,
    //   'back_id': back_id,
    // }).then((value) {
    //   print(value.data);
    //   emit(RegisterViewStateSuccess());
    // }).catchError((error) {
    //   emit(RegisterViewStateError(error.toString()));
    //   print('ffffffffffffff');
    //   print(error.toString());
    // });
  }

  File? Image;
  var picker = ImagePicker();

  Future getPostImageByCamera({required bool isCamera}) async {
    if (isCamera) {
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
      );
      if (pickedFile != null) {
        Image = File(pickedFile.path);
        emit(ImageImagePickedSuccessState());
      } else {
        print('no image selected');
        emit(ImageImagePickedErrorState());
      }
    } else {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        Image = File(pickedFile.path);
        emit(ImageImagePickedSuccessState());
      } else {
        print('no image selected');
        emit(ImageImagePickedErrorState());
      }
    }
  }

  File? FrontId;
  var pickerFrontId = ImagePicker();

  Future getFrontIdImage({required bool isCamera}) async {
    if (isCamera) {
      final pickedFile = await pickerFrontId.pickImage(
        source: ImageSource.camera,
      );
      if (pickedFile != null) {
        FrontId = File(pickedFile.path);
        emit(FrontIdImagePickedSuccessState());
      } else {
        print('no image selected');
        emit(FrontIdImagePickedErrorState());
      }
    } else {
      final pickedFile = await pickerFrontId.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        FrontId = File(pickedFile.path);
        emit(FrontIdImagePickedSuccessState());
      } else {
        print('no image selected');
        emit(FrontIdImagePickedErrorState());
      }
    }
  }

  File? BackId;
  var pickerBackId = ImagePicker();

  Future getBackIdImage({required bool isCamera}) async {
    if (isCamera) {
      final pickedFile = await pickerBackId.pickImage(
        source: ImageSource.camera,
      );
      if (pickedFile != null) {
        BackId = File(pickedFile.path);
        emit(BackIdImagePickedSuccessState());
      } else {
        print('no image selected');
        emit(BackIdImagePickedErrorState());
      }
    } else {
      final pickedFile = await pickerBackId.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        BackId = File(pickedFile.path);
        emit(BackIdImagePickedSuccessState());
      } else {
        print('no image selected');
        emit(BackIdImagePickedErrorState());
      }
    }
  }

  var emailControllerSignUpOne = TextEditingController();
  var keyFormSignUpOne = GlobalKey<FormState>();
  var passwordControllerSignUpOne = TextEditingController();
  var passwordConfirmControllerSignUpOne = TextEditingController();
  var firstNameControllerSignUpTwo = TextEditingController();
  var keyFormSignUpTwo = GlobalKey<FormState>();
  var lastNameControllerSignUpTwo = TextEditingController();
  var idNumberControllerSignUpTwo = TextEditingController();
  var mobileNumberControllerSignUpTwo = TextEditingController();
  bool isLast = false;
  dynamic index = 0;
  int textButton = 0;

  dynamic ChangeIndex(index) {
    textButton = index;
    if (index == screenRegister.length - 1) {
      isLast = true;
      print("true");
    } else {
      isLast = false;
    }
    emit(ChangeIndexSuccessState());
  }
}
