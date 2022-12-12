import 'package:flutter/material.dart';
import 'package:udhar_app/gen/assets.gen.dart';
import 'package:udhar_app/utils/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pinkColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                    height: 160.h,
                    width: 160.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Assets.images.udharLogo.path),
                      ),
                    ),
                  ),
                  Image.asset(
                    Assets.images.udharText.path,
                    height: 30.h,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
