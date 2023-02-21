import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:udhar_app/routing/router.gr.dart';

enum ScreenType { splashScreen, authScreen }

@injectable
class SplashProvider extends ChangeNotifier {
  ScreenType screenType = ScreenType.splashScreen;

  navigateToLogin(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      AutoRouter.of(context).pushAndPopUntil(
        const LoginScreen(),
        predicate: (route) => false,
      );
      notifyListeners();
    });
    notifyListeners();
  }
}
