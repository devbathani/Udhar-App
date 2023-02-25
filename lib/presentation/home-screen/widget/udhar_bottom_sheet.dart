import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:udhar_app/presentation/home-screen/widget/custom_dropdown.dart';
import 'package:udhar_app/presentation/home-screen/widget/custom_home_textfield.dart';
import 'package:udhar_app/providers/home/home_provider.dart';
import 'package:udhar_app/utils/color.dart';
import 'package:udhar_app/utils/text_styles.dart';

showUdharBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(25.0),
        topLeft: Radius.circular(25.0),
      ),
    ),
    builder: (context) {
      return Consumer<HomeProvider>(
        builder: (context, homeState, child) {
          return SizedBox(
            height: 400.h,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 100.w,
                      ),
                      Text(
                        "Add Udhar",
                        style: subTitleStyle.copyWith(
                          fontSize: 25.sp,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          HapticFeedback.vibrate();
                          AutoRouter.of(context).pop();
                        },
                        child: Icon(
                          Icons.close_rounded,
                          size: 30.w,
                          color: pinkColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 40.h,
                    child: CustomHomeTextField(
                      controller: homeState.nameController,
                      onChanged: (value) {},
                      hintText: "Name",
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  SizedBox(
                    height: 40.h,
                    child: CustomHomeTextField(
                      controller: homeState.phoneNumberController,
                      onChanged: (value) {},
                      hintText: "Phone Number",
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  SizedBox(
                    height: 40.h,
                    child: CustomHomeTextField(
                      keyboardType: TextInputType.number,
                      controller: homeState.amountController,
                      onChanged: (value) {},
                      hintText: "Amount",
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  SizedBox(
                    height: 40.h,
                    child: CustomHomeTextField(
                      controller: homeState.upiIdController,
                      onChanged: (value) {},
                      hintText: "UPI Id",
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomDropDown(
                    items: homeState.udharType,
                    value: homeState.selectedUdharType,
                    onchanged: (value) {
                      homeState.setUdharType(value);
                    },
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () async {
                      if (homeState.nameController.text.isEmpty ||
                          homeState.phoneNumberController.text.isEmpty ||
                          homeState.amountController.text.isEmpty ||
                          homeState.upiIdController.text.isEmpty) {
                        HapticFeedback.vibrate();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Please fill all details !!!",
                              style: subHeadingStyle.copyWith(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        HapticFeedback.vibrate();
                        await homeState.uploadUdhar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Udhar Uploaded",
                              style: subHeadingStyle.copyWith(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                            backgroundColor: pinkColor,
                          ),
                        );
                        await homeState.getUdharData();
                        AutoRouter.of(context).pop();
                      }
                    },
                    child: Container(
                      height: 40.h,
                      width: 130.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.r),
                        color: pinkColor,
                      ),
                      child: Center(
                        child: Text(
                          "UDHAAR",
                          style: headingStyle.copyWith(
                            fontSize: 14.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
