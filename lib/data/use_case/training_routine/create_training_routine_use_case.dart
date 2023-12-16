import 'package:dartz/dartz.dart';
import 'package:failure_stack/src/result.dart';
import 'package:gym_tracker_flutter/config/get_it_config.dart';
import 'package:gym_tracker_flutter/data/services/training_routine_service.dart';
import 'package:gym_tracker_flutter/data/use_case/server_failure.dart';
import 'package:gym_tracker_flutter/utills/use_case.dart';

class CreateTrainingRoutineUseCase extends UseCase<void, Map<String, dynamic>> {
  @override
  Future<Either<Failure, void>> call(Map<String, dynamic> params) async {
    try {
      final createdRoutines =
          await getIt<TrainingRoutineService>().createTrainingRoutine(params);
      return Right(createdRoutines);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
