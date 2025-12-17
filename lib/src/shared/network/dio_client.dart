import 'package:dio/dio.dart';

Dio createDio({String? baseUrl}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl ?? '',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 10),
      responseType: ResponseType.json,
    ),
  );
  dio.interceptors.add(
    LogInterceptor(
      requestBody: false,
      responseBody: false,
      requestHeader: false,
    ),
  );
  return dio;
}
