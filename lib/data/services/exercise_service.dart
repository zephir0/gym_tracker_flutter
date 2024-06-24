// import 'package:dio/dio.dart';
// import 'package:gymtracker/core/configs/api_endpoints.dart';
// import 'package:gymtracker/core/configs/token_manager.dart';
// import 'package:gymtracker/data/models/exercise.dart';
// import 'package:injectable/injectable.dart';
// @injectable
// class ExerciseService {
//   final Dio _dio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));

//   ExerciseService() {
//     _dio.interceptors.add(
//       InterceptorsWrapper(onRequest: (options, handler) async {
//         final authToken = await TokenManager.getToken();
//         if (authToken != null) {
//           options.headers['Authorization'] = 'Bearer $authToken';
//         }
//         return handler.next(options);
//       }),
//     );
//   }

//   Future<ExerciseResponseDto> createExercise(ExerciseDto exerciseDto) async {
//     try {
//       Response response = await _dio.post(ApiEndpoints.exercises, data: exerciseDto.toJson());
//       return ExerciseResponseDto.fromJson(response.data);
//     } catch (e) {
//       throw Exception('Failed to create exercise: $e');
//     }
//   }

//   Future<ExerciseResponseDto> editExercise(int exerciseId, ExerciseDto exerciseDto) async {
//     try {
//       Response response = await _dio.put('${ApiEndpoints.exercises}/$exerciseId', data: exerciseDto.toJson());
//       return ExerciseResponseDto.fromJson(response.data);
//     } catch (e) {
//       throw Exception('Failed to edit exercise: $e');
//     }
//   }

//   Future<List<ExerciseResponseDto>> getExercises() async {
//     try {
//       Response response = await _dio.get(ApiEndpoints.exercises);
//       return (response.data as List<dynamic>).map((json) => ExerciseResponseDto.fromJson(json)).toList();
//     } catch (e) {
//       throw Exception('Failed to fetch exercises: $e');
//     }
//   }

//   Future<void> deleteExercise(int exerciseId) async {
//     try {
//       await _dio.delete('${ApiEndpoints.exercises}/$exerciseId');
//     } catch (e) {
//       throw Exception('Failed to delete exercise: $e');
//     }
//   }
// }
