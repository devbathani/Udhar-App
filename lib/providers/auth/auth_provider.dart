import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:udhar_app/domain/auth/imp_auth_repo.dart';

@injectable
class AuthProvider extends ChangeNotifier {
   ImpAuthRepository repo;

  AuthProvider(this.repo);
}