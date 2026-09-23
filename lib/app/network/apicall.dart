import 'dart:developer';
import 'package:dio/dio.dart';

class ApiCall {
  ApiCall._();

  static final ApiCall instance = ApiCall._();

  static const String baseUrl = 'https://dummyjson.com';

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  Future<Response> get(String url) async {
    try {
      final response = await dio.get(url);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        log(e.response!.statusCode.toString());
        log(e.response!.data.toString());
      } else {
        log(e.message ?? "Unknown error");
      }
      return Response(
        requestOptions: RequestOptions(path: url),
        data: {},
        statusCode: 500,
      );
    }
  }

  Future<Response> post(String url, dynamic data) async {
    try {
      final response = await dio.post(url, data: data);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        log(e.response!.statusCode.toString());
        log(e.response!.data.toString());
      } else {
        log(e.message ?? "Unknown error");
      }
      return Response(
        requestOptions: RequestOptions(path: url),
        data: {},
        statusCode: 500,
      );
    }
  }
}
