// Package imports:

import 'package:dio/dio.dart';

abstract class ImpAuthRepository {
  Future<Response> login({required String email, required String password});
}
