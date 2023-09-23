import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udhar_app/gen/assets.gen.dart';
import 'package:udhar_app/providers/splash/splash_provider.dart';
import 'package:udhar_app/utils/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    Provider.of<SplashProvider>(context, listen: false)
        .navigateToAuthScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashProvider>(
      builder: (context, splashState, _) {
        return Scaffold(
          backgroundColor: primaryBackGroundColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 150.h,
                        width: 150.w,
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
                      Text(
                        "SipWise",
                        style: headingStyle.copyWith(
                          fontSize: 35.sp,
                          color: pinkColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
