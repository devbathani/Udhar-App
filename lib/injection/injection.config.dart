// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:udhar_app/core/api_client.dart' as _i3;
import 'package:udhar_app/core/firebase_core.dart' as _i4;
import 'package:udhar_app/domain/auth/imp_auth_repo.dart' as _i5;
import 'package:udhar_app/domain/home/imp_home_repo.dart' as _i7;
import 'package:udhar_app/infrastructure/auth/auth_repository.dart' as _i6;
import 'package:udhar_app/infrastructure/home/home_repository.dart' as _i8;
import 'package:udhar_app/providers/auth/auth_provider.dart' as _i10;
import 'package:udhar_app/providers/home/home_provider.dart' as _i11;
import 'package:udhar_app/providers/splash/splash_provider.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.APIClient>(() => _i3.APIClient());
    gh.factory<_i4.FirebaseClient>(() => _i4.FirebaseClient());
    gh.lazySingleton<_i5.ImpAuthRepository>(
        () => _i6.AuthRepo(gh<_i3.APIClient>()));
    gh.lazySingleton<_i7.ImpHomeRepository>(
        () => _i8.HomeRepo(gh<_i3.APIClient>()));
    gh.factory<_i9.SplashProvider>(() => _i9.SplashProvider());
    gh.factory<_i10.AuthProvider>(
        () => _i10.AuthProvider(gh<_i5.ImpAuthRepository>()));
    gh.factory<_i11.HomeProvider>(
        () => _i11.HomeProvider(gh<_i7.ImpHomeRepository>()));
    return this;
  }
}
