import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:gym_tracker_flutter/core/configs/api_endpoints.dart';
import 'package:gym_tracker_flutter/core/configs/injection.dart';
import 'package:logger/logger.dart'; 

class UserCubit extends Cubit<String> {
  final Dio _dio = getIt<Dio>();
  final Logger logger = getIt<Logger>();


  UserCubit() : super('');

  void fetchNameFromJson() async {
    logger.i("Fetching name from JSON");
    var url = '${ApiEndpoints.baseUrl}/users/logged-user';
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        final login = response.data['login'];
        logger.i("Fetched name from JSON: $login");
        emit(login);
      } else {
        logger.w("Failed to load name from JSON, status code: ${response.statusCode}");
        emit('Failed to load name from JSON');
      }
    } catch (e) {
      logger.e("Error fetching name from JSON: $e");
      emit('Failed to load name from JSON');
    }
  }
}
