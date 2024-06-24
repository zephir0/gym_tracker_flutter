import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:gym_tracker_flutter/core/configs/api_endpoints.dart';
import 'package:gym_tracker_flutter/core/configs/injection.config.dart';
import 'package:gym_tracker_flutter/core/token/token_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

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
     final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  dio.options = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: Duration(seconds: 60),
      receiveTimeout: Duration(seconds: 10),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (!options.path.contains(ApiEndpoints.authentication)) {
            String? token = await TokenStorage(secureStorage: FlutterSecureStorage()).getToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          logger.d('Response from ${response.requestOptions.uri}');
          logger.d('Response status code: ${response.statusCode}');
          logger.d('Response data: ${response.data}');
          return handler.next(response);
        },
       onError: (DioException e, handler) {
          if (e.response != null) {
            logger.e('Request failed with error: ${e.message}');
            logger.e('Request status code : ${e.response?.statusCode}');
            logger.e('Request status message: ${e.response?.statusMessage}');
          } else {
            logger.e('Request failed with error: ${e.message}');
            logger.e('Response is null');
          }
          return handler.next(e);
        },
        ),
    );
    return dio;
  }

  @singleton
  Logger provideLogger() {
    return Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 200,
        colors: true,
        printEmojis: true,
        printTime: true,
      ),
    );
  }

}