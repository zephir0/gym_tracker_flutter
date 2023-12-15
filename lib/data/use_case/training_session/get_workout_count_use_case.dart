import 'package:dartz/dartz.dart';
import 'package:failure_stack/failure_stack.dart';
import 'package:gym_tracker_flutter/config/get_it_config.dart';
import 'package:gym_tracker_flutter/data/services/training_session_service.dart';
import 'package:gym_tracker_flutter/data/use_case/server_failure.dart';
import 'package:gym_tracker_flutter/utills/no_parameters.dart';
import 'package:gym_tracker_flutter/utills/use_case.dart';

class GetWorkoutCountUseCase extends UseCase<int, NoParameters> {
  @override
  Future<Either<Failure, int>> call(NoParameters params) async {
    try {
      final count = await getIt<TrainingSessionService>().getWorkoutCount();
      return Right(count);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
