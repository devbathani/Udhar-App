import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

enum ScreenType { splashScreen, authScreen }

@injectable
class SplashProvider extends ChangeNotifier {
  ScreenType screenType = ScreenType.splashScreen;

  changeScreenType() {
    screenType = ScreenType.authScreen;
    notifyListeners();
  }
}
