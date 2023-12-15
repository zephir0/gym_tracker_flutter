import 'package:dartz/dartz.dart';
import 'package:failure_stack/failure_stack.dart';
import 'package:gym_tracker_flutter/config/get_it_config.dart';
import 'package:gym_tracker_flutter/data/models/training_session.dart';
import 'package:gym_tracker_flutter/data/services/training_session_service.dart';
import 'package:gym_tracker_flutter/data/use_case/server_failure.dart';
import 'package:gym_tracker_flutter/utills/no_parameters.dart';
import 'package:gym_tracker_flutter/utills/use_case.dart';

class FetchRecentTrainingSessionsUseCase
    extends UseCase<List<TrainingSession>, NoParameters> {
  @override
  Future<Either<Failure, List<TrainingSession>>> call(
      NoParameters params) async {
    try {
      final sessions =
          await getIt<TrainingSessionService>().fetchRecentTrainingSessions();
      return Right(sessions);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
