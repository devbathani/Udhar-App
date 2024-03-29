import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:udhar_app/utils/color.dart';
import 'package:udhar_app/utils/text_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
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
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 5.r,
            spreadRadius: 0.5.w,
            offset: const Offset(0, 3),
            color: Colors.white.withOpacity(0.33),
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
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(width: 2.w, color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(width: 2.w, color: Colors.white),
          ),
          hintText: hintText,
          hintStyle: subTitleStyle.copyWith(color: greyColor),
        ),
      ),
    );
  }
}
