import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/config/network/app_interceptor.dart';

final getDioOption = Provider<AppDioOption>((ref) => AppDioOption());

class AppDioOption{
  Dio dio = Dio();

  Dio initDioOption(){
    dio.options = BaseOptions(
      baseUrl: 'https://pokeapi.co/api/v2/',
      connectTimeout: const Duration(milliseconds: 60000),
      receiveTimeout: const Duration(milliseconds: 60000)
    );

    dio.interceptors.add(AppInterceptor());

    if(kDebugMode){
      dio.interceptors.add(
          LogInterceptor(responseBody: true, requestBody: true)
      );
    }

    return dio;
  }
}