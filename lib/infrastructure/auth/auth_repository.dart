import 'package:injectable/injectable.dart';
import 'package:udhar_app/core/api_client.dart';
import 'package:udhar_app/core/firebase_core.dart';
import 'package:udhar_app/domain/auth/imp_auth_repo.dart';
import 'package:udhar_app/domain/auth/user_list_entity.dart';
import 'package:udhar_app/utils/logger.dart';

@LazySingleton(as: ImpAuthRepository)
class AuthRepo extends ImpAuthRepository {
  final APIClient apiClient;

  AuthRepo(this.apiClient);

  @override
  Future<void> registerUser({required UserListEntity userListEntity}) async {
    await FirebaseClient.firebaseFirestore
        .collection("Users")
        .doc(userListEntity.name)
        .set(userListEntity.toJson());
    return logger.i("User Registered");
  }
}
