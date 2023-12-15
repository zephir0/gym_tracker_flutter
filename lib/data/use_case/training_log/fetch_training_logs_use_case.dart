import 'package:dartz/dartz.dart';
import 'package:failure_stack/failure_stack.dart';
import 'package:gym_tracker_flutter/config/get_it_config.dart';
import 'package:gym_tracker_flutter/data/models/training_log.dart';
import 'package:gym_tracker_flutter/data/services/training_log_service.dart';
import 'package:gym_tracker_flutter/data/use_case/server_failure.dart';
import 'package:gym_tracker_flutter/utills/use_case.dart';

class FetchTrainingLogsUseCase extends UseCase<List<TrainingLog>, int> {
  @override
  Future<Either<Failure, List<TrainingLog>>> call(int sessionId) async {
    try {
      final logs =
          await getIt<TrainingLogService>().fetchTrainingLogs(sessionId);
      return Right(logs);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
