import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:udhar_app/core/prefs.dart';
import 'package:udhar_app/gen/assets.gen.dart';
import 'package:udhar_app/injection/injection.dart';
import 'package:udhar_app/presentation/home-screen/widget/udhar_bottom_sheet.dart';
import 'package:udhar_app/presentation/home-screen/widget/udhar_data_container.dart';
import 'package:udhar_app/providers/home/home_provider.dart';
import 'package:udhar_app/providers/splash/splash_provider.dart';
import 'package:udhar_app/routing/router.gr.dart';
import 'package:udhar_app/utils/color.dart';
import 'package:udhar_app/utils/text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<HomeProvider>(context, listen: false).getUdharData();
    Provider.of<HomeProvider>(context, listen: false).setupPay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeState, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: InkWell(
            onTap: () {
              HapticFeedback.vibrate();
              showUdharBottomSheet(context);
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
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          getIt<AppPrefs>().uid.setValue('');
                          Provider.of<SplashProvider>(context, listen: false)
                              .setUserAuthStateToLogin();
                          AutoRouter.of(context).pushAndPopUntil(
                            const SplashScreen(),
                            predicate: (route) => false,
                          );
                        },
                        child: Icon(
                          Icons.logout,
                          size: 25.w,
                          color: pinkColor,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome",
                            style: headingStyle,
                          ),
                          SizedBox(
                            width: 250.w,
                            child: Text(
                              getIt<AppPrefs>().name.getValue().toUpperCase(),
                              style: headingStyle.copyWith(
                                color: pinkColor,
                                fontSize: 25.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Image.asset(
                        Assets.images.udharLogo.path,
                        height: 100.h,
                        width: 100.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  homeState.udharList!.isEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No Udhar",
                              style: headingStyle.copyWith(
                                fontSize: 20.sp,
                                color: greyColor,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: List.generate(
                                homeState.udharList!.length,
                                (index) {
                                  final udharData = homeState.udharList![index];
                                  return UdharDataContainer(
                                    udharData: udharData,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
