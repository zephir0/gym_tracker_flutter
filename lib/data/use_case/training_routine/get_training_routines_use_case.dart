import 'package:dartz/dartz.dart';
import 'package:failure_stack/src/result.dart';
import 'package:gym_tracker_flutter/core/configs/injection.dart';
import 'package:gym_tracker_flutter/core/constants/no_parameters.dart';
import 'package:gym_tracker_flutter/core/constants/use_case.dart';
import 'package:gym_tracker_flutter/data/models/training_routine.dart';
import 'package:gym_tracker_flutter/data/services/training_routine_service.dart';
import 'package:gym_tracker_flutter/data/use_case/server_failure.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTrainingRoutinesUseCase
    extends UseCase<List<TrainingRoutine>, NoParameters> {
  @override
  Future<Either<Failure, List<TrainingRoutine>>> call(
      NoParameters params) async {
    try {
      final trainingRoutines =
          await getIt<TrainingRoutineService>().getTrainingRoutines();
      return Right(trainingRoutines);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
