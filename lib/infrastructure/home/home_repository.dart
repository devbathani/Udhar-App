import 'package:injectable/injectable.dart';
import 'package:udhar_app/core/api_client.dart';
import 'package:udhar_app/core/firebase_core.dart';
import 'package:udhar_app/core/prefs.dart';
import 'package:udhar_app/domain/home/imp_home_repo.dart';
import 'package:udhar_app/domain/home/udhar_list_entity.dart';
import 'package:udhar_app/injection/injection.dart';
import 'package:udhar_app/utils/logger.dart';

@LazySingleton(as: ImpHomeRepository)
class HomeRepo extends ImpHomeRepository {
  final APIClient apiClient;

  HomeRepo(this.apiClient);

  @override
  Future<void> uploadUdhar({required UdharListEntity udharListEntity}) async {
    await FirebaseClient.firebaseFirestore
        .collection("Users")
        .doc(getIt<AppPrefs>().name.getValue())
        .collection("Udhar")
        .add(udharListEntity.toJson());
    return logger.i("Udhar Uploaded");
  }

  @override
  Stream<List<UdharListEntity>> getUdharData() {
    logger.w("Getting Data for ${getIt<AppPrefs>().name.getValue()}");
    List<UdharListEntity> listEntity = [];
    return FirebaseClient.firebaseFirestore
        .collection("Users")
        .doc(getIt<AppPrefs>().name.getValue())
        .collection("Udhar")
        .snapshots()
        .map((event) {
      for (var element in event.docs) {
        listEntity.add(UdharListEntity.fromJson(element.data()));
      }
      return listEntity;
    });
  }
}
