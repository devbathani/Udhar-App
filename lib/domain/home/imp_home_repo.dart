// Package imports:

import 'package:udhar_app/domain/home/udhar_list_entity.dart';

abstract class ImpHomeRepository {
  Future<void> uploadUdhar({required UdharListEntity udharListEntity});
  Stream<List<UdharListEntity>> getUdharData();
}
