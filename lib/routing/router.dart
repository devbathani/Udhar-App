// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:udhar_app/presentation/auth-screen/enter_otp_screen.dart';
import 'package:udhar_app/presentation/auth-screen/login_screen.dart';
import 'package:udhar_app/presentation/splash-screen/splash_screen.dart';

import '../presentation/auth-screen/register_screen.dart';

@CustomAutoRouter(
  replaceInRouteName: 'Page,Route',
  transitionsBuilder: TransitionsBuilders.fadeIn,
  routes: <AutoRoute>[
    CustomRoute(page: SplashScreen, initial: true, path: 'splash'),
    CustomRoute(page: LoginScreen, initial: true, path: 'loginScreen'),
    CustomRoute(page: RegisterScreen, initial: true, path: 'registerScreen'),
    CustomRoute(page: EnterOtpScreen, initial: true, path: 'otpScreen'),
  ],
)
class $AppRouter {}
