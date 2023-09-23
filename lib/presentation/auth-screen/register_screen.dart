import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:udhar_app/gen/assets.gen.dart';
import 'package:udhar_app/presentation/auth-screen/widgets/custom_textfield.dart';
import 'package:udhar_app/providers/auth/auth_provider.dart';
import 'package:udhar_app/routing/router.gr.dart';
import 'package:udhar_app/utils/color.dart';
import 'package:udhar_app/utils/text_styles.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, registerState, _) {
        return Scaffold(
          backgroundColor: primaryBackGroundColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 60.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Hello",
                      style: headingStyle,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "Their",
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
                    "Hope you doing well Lets Register !!!",
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Register",
                            style: subTitleStyle,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomTextField(
                            controller: registerState.nameController,
                            onChanged: (value) {},
                            hintText: "Name",
                            keyboardType: TextInputType.name,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomTextField(
                            controller: registerState.phoneNumberController,
                            onChanged: (value) {},
                            hintText: "Phone",
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10)
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomTextField(
                            controller: registerState.emailController,
                            onChanged: (value) {},
                            hintText: "Email",
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomTextField(
                            controller: registerState.upiIdController,
                            onChanged: (value) {},
                            hintText: "UPI Id",
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          InkWell(
                            onTap: () async {
                              if (registerState.nameController.text.isEmpty ||
                                  registerState
                                      .phoneNumberController.text.isEmpty ||
                                  registerState.emailController.text.isEmpty ||
                                  registerState.upiIdController.text.isEmpty) {
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
                              } else if (EmailValidator.validate(
                                      registerState.emailController.text) ==
                                  false) {
                                HapticFeedback.vibrate();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Please enter a valid Email !!!",
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
                                registerState.startTimer();
                                // await registerState.sendOtp(context);
                                AutoRouter.of(context).push(
                                  const EnterOtpScreen(),
                                );
                              }
                            },
                            child: Container(
                              height: 60.h,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: pinkColor,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child:
                                    registerState.otpState == OtpState.sending
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text(
                                            "Register",
                                            style: subTitleStyle.copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
