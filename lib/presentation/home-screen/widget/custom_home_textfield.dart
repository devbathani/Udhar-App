import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:udhar_app/utils/color.dart';
import 'package:udhar_app/utils/text_styles.dart';

class CustomHomeTextField extends StatelessWidget {
  const CustomHomeTextField(
      {super.key,
      required this.controller,
      this.keyboardType,
      this.inputFormatters,
      required this.onChanged,
      required this.hintText});
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String) onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 5.r,
            spreadRadius: 0.5.w,
            offset: const Offset(0, 3),
            color: Colors.black.withOpacity(0.33),
          ),
        ],
      ),
      child: TextField(
        style: subTitleStyle.copyWith(color: greyColor),
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(width: 2.w, color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(width: 2.w, color: Colors.black),
          ),
          hintText: hintText,
          hintStyle: subTitleStyle.copyWith(color: greyColor),
        ),
      ),
    );
  }
}
