import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:gym_tracker_flutter/core/configs/api_endpoints.dart';
import 'package:gym_tracker_flutter/core/configs/injection.config.dart';
import 'package:gym_tracker_flutter/core/token/token_storage.dart';
import 'package:injectable/injectable.dart';

GetIt getIt = GetIt.instance;

@InjectableInit(  
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)  
void configureDependencies() => getIt.init(); 

@module
abstract class InjectableModule {
  @singleton
  Dio provideDio() {
    final dio = Dio();
    
    dio.options = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: Duration(seconds: 60),
      receiveTimeout: Duration(seconds: 10),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = await TokenStorage(secureStorage: FlutterSecureStorage()).getToken();
          
          options.headers['Authorization'] = 'Bearer $token';
          print(token);
          return handler.next(options);
        },
      ),
    );

    return dio;
  }
}