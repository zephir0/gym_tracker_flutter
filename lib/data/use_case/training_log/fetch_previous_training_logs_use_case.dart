import 'package:dartz/dartz.dart';
import 'package:failure_stack/failure_stack.dart';
import 'package:gym_tracker_flutter/core/configs/injection.dart';
import 'package:gym_tracker_flutter/core/constants/use_case.dart';
import 'package:gym_tracker_flutter/data/models/training_log.dart';
import 'package:gym_tracker_flutter/data/services/training_log_service.dart';
import 'package:gym_tracker_flutter/data/use_case/server_failure.dart';
import 'package:injectable/injectable.dart';

@injectable
class FetchPreviousTrainingLogsUseCase extends UseCase<List<TrainingLog>, int> {
  @override
  Future<Either<Failure, List<TrainingLog>>> call(int routineId) async {
    try {
      final logs = await getIt<TrainingLogService>()
          .fetchPreviousTrainingLogs(routineId);
      return Right(logs);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
