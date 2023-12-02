import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final String? hintText;
  final Widget? prefix;
  final Widget? suffix;

  final bool obscureText;
  final int? maxLength;
  final FormFieldValidator<String>? validator;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.textInputType = TextInputType.text,
    this.hintText,
    this.prefix,
    this.validator,
    this.obscureText = false,
    this.maxLength,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength ?? 50,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 17),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),
        ),
        suffixIcon: suffix,
        prefixIcon: prefix,
      ),
      // textInputAction: textInputAction,
      keyboardType: textInputType,
      obscureText: obscureText,
      validator: validator,
    );
  }
}
