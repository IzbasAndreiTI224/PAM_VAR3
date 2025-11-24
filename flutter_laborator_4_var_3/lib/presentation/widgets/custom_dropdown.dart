import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class CustomDropdown extends StatelessWidget {
  CustomDropdown({
    Key? key,
    this.hintText,
    this.items,
    this.value,
    this.onChanged,
    this.validator,
    this.borderColor,
    this.enabled = true,
  }) : super(key: key);

  final String? hintText;
  final List<String>? items;
  final String? value;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final Color? borderColor;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: enabled ? onChanged : null,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText ?? "Select an option",
        hintStyle: TextStyleHelper.instance.body14MediumMetropolis,
        filled: true,
        fillColor: appTheme.white_A700,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12.h,
          vertical: 10.h,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.h),
          borderSide: BorderSide(
            color: borderColor ?? Color(0xFF9B9B9B),
            width: 1.h,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.h),
          borderSide: BorderSide(
            color: borderColor ?? Color(0xFF9B9B9B),
            width: 1.h,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.h),
          borderSide: BorderSide(
            color: borderColor ?? Color(0xFF9B9B9B),
            width: 1.h,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.h),
          borderSide: BorderSide(
            color: appTheme.redCustom,
            width: 1.h,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.h),
          borderSide: BorderSide(
            color: appTheme.redCustom,
            width: 1.h,
          ),
        ),
      ),
      style: TextStyleHelper.instance.body14MediumMetropolis,
      items: items?.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: TextStyleHelper.instance.body14MediumMetropolis,
          ),
        );
      }).toList(),
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: appTheme.gray_900,
        size: 20.h,
      ),
    );
  }
}