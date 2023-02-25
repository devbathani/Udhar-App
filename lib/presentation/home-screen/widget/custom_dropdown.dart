import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:udhar_app/utils/color.dart';
import 'package:udhar_app/utils/text_styles.dart';
import 'dart:math' as math;

class CustomDropDown extends StatelessWidget {
  final List<String>? items;
  final dynamic value;
  final Function(String?)? onchanged;
  const CustomDropDown({
    Key? key,
    this.items,
    this.value,
    this.onchanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      width: MediaQuery.of(context).size.width,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: Colors.black,
          width: 2.w,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5.r,
            spreadRadius: 0.5.w,
            offset: const Offset(0, 3),
            color: Colors.black.withOpacity(0.33),
          ),
        ],
      ),
      //padding: EdgeInsets.only(left: Get.width * 0.01),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          icon: Transform.rotate(
            angle: -math.pi / 2,
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20.w,
              color: pinkColor,
            ),
          ),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(10),
          items: items!.map((String caste) {
            return DropdownMenuItem<String>(
              value: caste,
              child: Text(
                caste,
                style: subTitleStyle.copyWith(
                  color: greyColor,
                ),
              ),
            );
          }).toList(),
          value: value,
          onChanged: onchanged!,
        ),
      ),
    );
  }
}
