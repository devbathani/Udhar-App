// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:udhar_app/presentation/splash-screen/splash_screen.dart';

@CustomAutoRouter(
  replaceInRouteName: 'Page,Route',
  transitionsBuilder: TransitionsBuilders.fadeIn,
  routes: <AutoRoute>[
    CustomRoute(page: SplashScreen, initial: true, path: 'splash'),
  ],
)
class $AppRouter {}
