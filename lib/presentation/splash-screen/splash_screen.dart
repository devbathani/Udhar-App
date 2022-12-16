import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udhar_app/gen/assets.gen.dart';
import 'package:udhar_app/providers/splash/splash_provider.dart';
import 'package:udhar_app/utils/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:udhar_app/utils/commons.dart';
import 'package:udhar_app/utils/text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1500,
      ),
    );
    changeScreenType();
  }

  changeScreenType() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    if (mounted) {
      Provider.of<SplashProvider>(context, listen: false).changeScreenType();
      animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashProvider>(
      builder: (context, splashState, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              AnimatedPositioned(
                duration: duration,
                left: splashState.screenType == ScreenType.splashScreen
                    ? 0.w
                    : 250.w,
                bottom: splashState.screenType == ScreenType.splashScreen
                    ? 0.h
                    : 550.h,
                child: AnimatedContainer(
                  curve: Curves.decelerate,
                  height: splashState.screenType == ScreenType.splashScreen
                      ? MediaQuery.of(context).size.height
                      : 180.h,
                  width: splashState.screenType == ScreenType.splashScreen
                      ? MediaQuery.of(context).size.width
                      : 180.w,
                  duration: duration,
                  decoration: ShapeDecoration(
                    shape: splashState.screenType == ScreenType.splashScreen
                        ? const RoundedRectangleBorder()
                        : const CircleBorder(),
                    color: pinkColor,
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: duration,
                top: splashState.screenType == ScreenType.splashScreen
                    ? 280.h
                    : 250.h,
                right: splashState.screenType == ScreenType.splashScreen
                    ? 120.w
                    : 140.w,
                child: Column(
                  children: [
                    AnimatedContainer(
                      height: splashState.screenType == ScreenType.splashScreen
                          ? 150.h
                          : 100.h,
                      width: splashState.screenType == ScreenType.splashScreen
                          ? 150.w
                          : 100.w,
                      duration: duration,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            Assets.images.udharLogo.path,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    splashState.screenType == ScreenType.splashScreen
                        ? Image.asset(
                            Assets.images.udharText.path,
                            height: 30.h,
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              splashState.screenType == ScreenType.authScreen
                  ? Positioned(
                      top: 150.h,
                      left: 70.w,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Hello",
                                style: headingStyle,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                "There",
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
                        ],
                      ),
                    )
                  : Container(),
              splashState.screenType == ScreenType.authScreen
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(top: 350.h),
                        child: Column(
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
                                      cursorColor: pinkColor,
                                      style: subTitleStyle.copyWith(
                                        color: greyColor,
                                      ),
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          borderSide: BorderSide(
                                            width: 2.w,
                                            color: Colors.black,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          borderSide: BorderSide(
                                            width: 2.w,
                                            color: Colors.black,
                                          ),
                                        ),
                                        hintText: "Phone number",
                                        hintStyle: subTitleStyle.copyWith(
                                          color: greyColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Container(
                                    height: 60.h,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: pinkColor,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Send OTP",
                                        style: subTitleStyle.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 60.h,
                            ),
                            Divider(
                              color: Colors.black,
                              thickness: 1.w,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Ohhh I haven't",
                                      style: subTitleStyle.copyWith(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Text(
                                      "Registered",
                                      style: subTitleStyle.copyWith(
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Text(
                                      "yet!!!",
                                      style: subTitleStyle.copyWith(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Container(
                                  height: 30.h,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    color: pinkColor,
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Register",
                                      style: subTitleStyle.copyWith(
                                        color: Colors.white,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
