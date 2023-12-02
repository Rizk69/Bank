abstract class RegisterState {}

class IntializeRegisterState extends RegisterState {}

class RegisterViewStateLoading extends RegisterState {}

class RegisterViewStateSuccess extends RegisterState {}

class RegisterViewStateError extends RegisterState {
  final String error;

  RegisterViewStateError(this.error);
}

class ChangeIconPasswordSuccess extends RegisterState {}

class ImageImagePickedSuccessState extends RegisterState {}

class ImageImagePickedErrorState extends RegisterState {}

class FrontIdImagePickedSuccessState extends RegisterState {}

class FrontIdImagePickedErrorState extends RegisterState {}

class BackIdImagePickedSuccessState extends RegisterState {}

class BackIdImagePickedErrorState extends RegisterState {}

class ChangeIndexSuccessState extends RegisterState {}
