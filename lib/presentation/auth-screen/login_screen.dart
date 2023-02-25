import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otpless_flutter/otpless_flutter.dart';
import 'package:provider/provider.dart';
import 'package:udhar_app/core/firebase_core.dart';
import 'package:udhar_app/core/prefs.dart';
import 'package:udhar_app/gen/assets.gen.dart';
import 'package:udhar_app/injection/injection.dart';
import 'package:udhar_app/providers/auth/auth_provider.dart';
import 'package:udhar_app/routing/router.gr.dart';
import 'package:udhar_app/utils/color.dart';
import 'package:udhar_app/utils/logger.dart';
import 'package:udhar_app/utils/text_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _otplessFlutterPlugin = Otpless();

  // ** Function to initiate the login process
  void initiateWhatsappLogin(String intentUrl) async {
    var result =
        await _otplessFlutterPlugin.loginUsingWhatsapp(intentUrl: intentUrl);
    switch (result['code']) {
      case "581":
        print(result['message'].toString());
        //TODO: handle whatsapp not found
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // ** Function that is called when page is loaded
  // ** We can check the auth state in this function
  Future<void> initPlatformState() async {
    _otplessFlutterPlugin.authStream.listen((token) {
      // TODO: Handle user token like storing in SharedPreferences or navigation

      if (token != null) {
        setState(() {
          final User user = FirebaseClient.firebaseAuth.currentUser!;
          getIt<AppPrefs>().uid.setValue(user.uid);
          logger.i("UID : ${getIt<AppPrefs>().uid.getValue()}");
          AutoRouter.of(context).pushAndPopUntil(
            const HomeScreen(),
            predicate: (route) => false,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, loginState, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 120.h,
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
                      "Again",
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Login",
                            style: subTitleStyle,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
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
                              controller: loginState.phoneNumberController,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10)
                              ],
                              onChanged: (number) async {
                                if (number.length == 10) {
                                  FocusScope.of(context).nextFocus();
                                  loginState.setAuthButtonToActive();
                                } else if (number.length < 10) {
                                  loginState.setAuthButtonToDeactive();
                                }
                              },
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(
                                      width: 2.w, color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(
                                      width: 2.w, color: Colors.black),
                                ),
                                hintText: "Phone number",
                                hintStyle:
                                    subTitleStyle.copyWith(color: greyColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          InkWell(
                            onTap: () async {
                              if (loginState.authButtonState ==
                                  AuthButtonState.active) {
                                HapticFeedback.vibrate();
                                loginState.startTimer();
                                await loginState.sendOtp(context);
                              } else {
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
                              }
                            },
                            child: Container(
                              height: 60.h,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: loginState.authButtonState ==
                                        AuthButtonState.active
                                    ? pinkColor
                                    : greyColor,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: loginState.otpState == OtpState.sending
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        "Send OTP",
                                        style: subTitleStyle.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "OR",
                                style: subTitleStyle.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          InkWell(
                            onTap: () {
                              HapticFeedback.vibrate();
                              initiateWhatsappLogin(
                                  "https://dev-test.authlink.me?redirectUri=otpless://dev-test");
                            },
                            child: Container(
                              height: 60.h,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: greenColor,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: Text(
                                  "Login Via WhatsApp",
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
