// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../presentation/auth-screen/enter_otp_screen.dart' as _i4;
import '../presentation/auth-screen/login_screen.dart' as _i2;
import '../presentation/auth-screen/register_screen.dart' as _i3;
import '../presentation/home-screen/home_screen.dart' as _i5;
import '../presentation/splash-screen/splash_screen.dart' as _i1;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    SplashScreen.name: (routeData) {
      return _i6.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.SplashScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginScreen.name: (routeData) {
      return _i6.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i2.LoginScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    RegisterScreen.name: (routeData) {
      return _i6.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i3.RegisterScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    EnterOtpScreen.name: (routeData) {
      return _i6.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.EnterOtpScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    HomeScreen.name: (routeData) {
      return _i6.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.HomeScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: 'splash',
          fullMatch: true,
        ),
        _i6.RouteConfig(
          SplashScreen.name,
          path: 'splash',
        ),
        _i6.RouteConfig(
          LoginScreen.name,
          path: 'loginScreen',
        ),
        _i6.RouteConfig(
          RegisterScreen.name,
          path: 'registerScreen',
        ),
        _i6.RouteConfig(
          EnterOtpScreen.name,
          path: 'otpScreen',
        ),
        _i6.RouteConfig(
          HomeScreen.name,
          path: 'homeScreen',
        ),
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashScreen extends _i6.PageRouteInfo<void> {
  const SplashScreen()
      : super(
          SplashScreen.name,
          path: 'splash',
        );

  static const String name = 'SplashScreen';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginScreen extends _i6.PageRouteInfo<void> {
  const LoginScreen()
      : super(
          LoginScreen.name,
          path: 'loginScreen',
        );

  static const String name = 'LoginScreen';
}

/// generated route for
/// [_i3.RegisterScreen]
class RegisterScreen extends _i6.PageRouteInfo<void> {
  const RegisterScreen()
      : super(
          RegisterScreen.name,
          path: 'registerScreen',
        );

  static const String name = 'RegisterScreen';
}

/// generated route for
/// [_i4.EnterOtpScreen]
class EnterOtpScreen extends _i6.PageRouteInfo<void> {
  const EnterOtpScreen()
      : super(
          EnterOtpScreen.name,
          path: 'otpScreen',
        );

  static const String name = 'EnterOtpScreen';
}

/// generated route for
/// [_i5.HomeScreen]
class HomeScreen extends _i6.PageRouteInfo<void> {
  const HomeScreen()
      : super(
          HomeScreen.name,
          path: 'homeScreen',
        );

  static const String name = 'HomeScreen';
}
