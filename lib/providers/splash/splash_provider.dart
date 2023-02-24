import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:udhar_app/core/prefs.dart';
import 'package:udhar_app/injection/injection.dart';
import 'package:udhar_app/routing/router.gr.dart';

enum UserAuthState { login, register }

@injectable
class SplashProvider extends ChangeNotifier {
  //Enums
  UserAuthState userAuthState = UserAuthState.register;

  setUserAuthStateToLogin() async {
    userAuthState = UserAuthState.login;
    notifyListeners();
  }

  navigateToAuthScreen(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      if (getIt<AppPrefs>().name.getValue().isEmpty) {
        userAuthState = UserAuthState.register;
        AutoRouter.of(context).pushAndPopUntil(
          const RegisterScreen(),
          predicate: (route) => false,
        );
        notifyListeners();
      } else {
        if (getIt<AppPrefs>().uid.getValue() == '') {
          userAuthState = UserAuthState.login;
          AutoRouter.of(context).pushAndPopUntil(
            const LoginScreen(),
            predicate: (route) => false,
          );
          notifyListeners();
        } else {
          AutoRouter.of(context).pushAndPopUntil(
            const HomeScreen(),
            predicate: (route) => false,
          );
          notifyListeners();
        }
      }
    });
  }
}
