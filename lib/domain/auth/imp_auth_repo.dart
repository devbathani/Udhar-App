// Package imports:

import 'package:udhar_app/domain/auth/user_list_entity.dart';

abstract class ImpAuthRepository {
  Future<void> registerUser({required UserListEntity userListEntity});
}
