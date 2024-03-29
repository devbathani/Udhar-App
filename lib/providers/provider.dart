import 'package:provider/provider.dart';
import 'package:udhar_app/injection/injection.dart';
import 'package:udhar_app/providers/auth/auth_provider.dart';
import 'package:udhar_app/providers/home/home_provider.dart';
import 'package:udhar_app/providers/splash/splash_provider.dart';

final providers = [
  ChangeNotifierProvider<SplashProvider>(
    create: (context) => getIt<SplashProvider>(),
    lazy: false,
  ),
  ChangeNotifierProvider<AuthProvider>(
    create: (context) => getIt<AuthProvider>(),
    lazy: false,
  ),
  ChangeNotifierProvider<HomeProvider>(
    create: (context) => getIt<HomeProvider>(),
    lazy: false,
  ),
];
