import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:udhar_app/domain/home/udhar_list_entity.dart';
import 'package:udhar_app/utils/color.dart';
import 'package:udhar_app/utils/text_styles.dart';

class UdharDataContainer extends StatelessWidget {
  const UdharDataContainer({super.key, required this.udharData});
  final UdharListEntity udharData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        height: 220.h,
        width: 320.w,
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
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Name : ",
                    style: subTitleStyle.copyWith(
                      color: greyColor,
                      fontSize: 15.sp,
                    ),
                  ),
                  Text(
                    udharData.name,
                    style: subTitleStyle.copyWith(
                      color: pinkColor,
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Phone number : ",
                    style: subTitleStyle.copyWith(
                      color: greyColor,
                      fontSize: 15.sp,
                    ),
                  ),
                  Text(
                    udharData.phoneNumber,
                    style: subTitleStyle.copyWith(
                      color: pinkColor,
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "UPI Id : ",
                    style: subTitleStyle.copyWith(
                      color: greyColor,
                      fontSize: 15.sp,
                    ),
                  ),
                  Text(
                    udharData.upiId,
                    style: subTitleStyle.copyWith(
                      color: pinkColor,
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Udhar Type : ",
                    style: subTitleStyle.copyWith(
                      color: greyColor,
                      fontSize: 15.sp,
                    ),
                  ),
                  Text(
                    udharData.udharType,
                    style: subTitleStyle.copyWith(
                      color: pinkColor,
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                height: 50.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: pinkColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: udharData.udharType == "Udhar Given"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Rs${udharData.amount}",
                            style: headingStyle.copyWith(
                              color: Colors.white,
                              fontSize: 15.sp,
                            ),
                          ),
                        ],
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Rs${udharData.amount}",
                              style: headingStyle.copyWith(
                                color: Colors.white,
                                fontSize: 15.sp,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              height: 30.h,
                              width: 130.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: Text(
                                  "Pay",
                                  style: subTitleStyle.copyWith(
                                    fontSize: 12.sp,
                                    color: pinkColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
