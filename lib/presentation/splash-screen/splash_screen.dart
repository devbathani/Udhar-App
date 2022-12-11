import 'package:flutter/material.dart';
import 'package:udhar_app/gen/assets.gen.dart';
import 'package:udhar_app/utils/color.dart';

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
              Image.asset(
                Assets.images.udharLogo.path,
              ),
            ],
          )
        ],
      ),
    );
  }
}
