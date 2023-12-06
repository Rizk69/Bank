import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListPickerField extends StatefulWidget {
  final String label;
  final bool isRequired;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  CustomListPickerField({
    required this.label,
    required this.items,
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
      padding: EdgeInsets.only(bottom: 20.h),
      isExpanded: true,
      borderRadius: BorderRadius.circular(15),
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.isRequired ? 'Select ${widget.label}' : null,
      ),
      items: widget.items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
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
