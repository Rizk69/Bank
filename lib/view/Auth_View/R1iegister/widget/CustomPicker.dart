import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomListPickerField extends StatefulWidget {
  final String label;
  final bool isRequired;
  final List<String> itemsCode;
  final List<String> itemsImage;
  final List<String> itemsName;
  final ValueChanged<String?> onChanged;

  const CustomListPickerField({
    super.key,
    required this.label,
    required this.itemsCode,
    required this.itemsImage,
    required this.itemsName,
    required this.onChanged,
    this.isRequired = false,
  });

  @override
  _CustomListPickerFieldState createState() => _CustomListPickerFieldState();
}

class _CustomListPickerFieldState extends State<CustomListPickerField> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      focusColor: Colors.white,
      padding: EdgeInsets.only(bottom: 35.h),
      isExpanded: true,
      borderRadius: BorderRadius.circular(15),
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.isRequired ? '${'Select'.tr} ${widget.label}' : null,
      ),
      items: List.generate(
        widget.itemsCode.length,
        (index) => DropdownMenuItem<String>(
          value: widget.itemsCode[index],
          child: Row(
            children: [
              SizedBox(
                width: 40,
                child: Text(
                  widget.itemsCode[index],
                  overflow: TextOverflow.clip,
                ),
              ),
              const SizedBox(width: 10), // Spacing
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    widget.itemsImage[index],
                    width: 20,
                    height: 30,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                          Icons.error); // Placeholder widget in case of error
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ).toList(),
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
        widget.onChanged(value);
      },
      value: selectedValue,
      validator: (value) {
        if (widget.isRequired && (value == null || value.isEmpty)) {
          return 'Please select ${widget.label}';
        }
        return null;
      },
    );
  }
}
