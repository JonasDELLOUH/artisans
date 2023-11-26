import 'package:dio/dio.dart';

class DioProvider {
  DioProvider._();

  static Dio _init() {
    Dio dio = Dio();
    return dio;
  }

  static Dio? _api;

  static Dio get client => _api ?? (_api = _init());
}
