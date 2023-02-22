import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:udhar_app/gen/assets.gen.dart';
import 'package:udhar_app/providers/auth/auth_provider.dart';
import 'package:udhar_app/providers/splash/splash_provider.dart';
import 'package:udhar_app/utils/color.dart';
import 'package:udhar_app/utils/text_styles.dart';

class EnterOtpScreen extends StatelessWidget {
  const EnterOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: Consumer<AuthProvider>(
        builder: (context, otpState, _) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 100.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "OTP",
                        style: headingStyle,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        "Sent",
                        style: headingStyle.copyWith(color: pinkColor),
                      ),
                      Text(
                        "!",
                        style: headingStyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    width: 250.w,
                    child: Text(
                      "Welcome back you’ve been missed!",
                      style: subHeadingStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    height: 100.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          Assets.images.udharLogo.path,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.w, right: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "OTP",
                          style: subTitleStyle,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.h, horizontal: 3.w),
                          child: Consumer<AuthProvider>(
                            builder: (context, authState, _) {
                              return PinCodeTextField(
                                length: 6,
                                obscureText: false,
                                enablePinAutofill: true,
                                autoFocus: true,
                                controller: otpState.otpController,
                                animationType: AnimationType.fade,
                                animationDuration:
                                    const Duration(milliseconds: 300),
                                onChanged: (otp) async {
                                  if (otp.length == 6) {
                                    if (Provider.of<SplashProvider>(context,
                                                listen: false)
                                            .userAuthState ==
                                        UserAuthState.login) {
                                      otpState.verifyLoginOtp(context);
                                    } else {
                                      otpState.verifyRegistrationOtp(context);
                                    }
                                  } else if (otp.length != 6 || otp.isEmpty) {}
                                },
                                keyboardType: TextInputType.number,
                                appContext: context,
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(3.w),
                                  fieldHeight: 35.h,
                                  fieldWidth: 40.w,
                                  activeColor: authState.otpVerificationState ==
                                              OtpVerificationState.unverified ||
                                          authState.otpVerificationState ==
                                              OtpVerificationState.success
                                      ? pinkColor
                                      : Colors.red,
                                  activeFillColor: authState
                                                  .otpVerificationState ==
                                              OtpVerificationState.unverified ||
                                          authState.otpVerificationState ==
                                              OtpVerificationState.success
                                      ? pinkColor
                                      : Colors.red,
                                  selectedColor: authState
                                                  .otpVerificationState ==
                                              OtpVerificationState.unverified ||
                                          authState.otpVerificationState ==
                                              OtpVerificationState.success
                                      ? pinkColor
                                      : Colors.red,
                                  selectedFillColor: const Color(0xff121212),
                                  inactiveFillColor: const Color(0xff121212),
                                  inactiveColor: const Color(0xff121212),
                                  disabledColor: const Color(0xff121212),
                                  errorBorderColor: Colors.red,
                                  borderWidth: 1.w,
                                ),
                                cursorColor: Colors.white,
                                textStyle: headingStyle,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        otpState.otpVerificationState ==
                                OtpVerificationState.failure
                            ? Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Invalid OTP, Please try again",
                                      style: subTitleStyle.copyWith(
                                          color: Colors.red, fontSize: 18.sp),
                                    ),
                                  ],
                                ),
                              )
                            : otpState.otpVerificationState ==
                                    OtpVerificationState.success
                                ? Padding(
                                    padding: EdgeInsets.only(bottom: 10.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "OTP Verified Successfully!",
                                          style: subTitleStyle.copyWith(
                                            color: greenColor,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(bottom: 10.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Didn’t receive it?",
                                          style: subTitleStyle.copyWith(
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        otpState.isTimerStarted
                                            ? Text(
                                                "Resend in ${otpState.start}",
                                                style: subTitleStyle.copyWith(
                                                  fontSize: 18.sp,
                                                  color: greyColor,
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () async {},
                                                child: Text(
                                                  "Resend",
                                                  style: subTitleStyle.copyWith(
                                                    color: pinkColor,
                                                    fontSize: 18.sp,
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
