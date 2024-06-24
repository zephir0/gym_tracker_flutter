import 'package:dartz/dartz.dart';
import 'package:failure_stack/src/result.dart';
import 'package:gym_tracker_flutter/core/configs/injection.dart';
import 'package:gym_tracker_flutter/core/constants/use_case.dart';
import 'package:gym_tracker_flutter/data/services/training_routine_service.dart';
import 'package:gym_tracker_flutter/data/use_case/server_failure.dart';
import 'package:injectable/injectable.dart';

@injectable
class ArchiveTrainingRoutineUseCase extends UseCase<void, int> {
  @override
  Future<Either<Failure, void>> call(int params) async {
    try {
      final archivedRoutines =
          await getIt<TrainingRoutineService>().archiveTrainingRoutine(params);
      return Right(archivedRoutines);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
