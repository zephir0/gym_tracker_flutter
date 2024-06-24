import 'package:dartz/dartz.dart';
import 'package:failure_stack/failure_stack.dart';
import 'package:gym_tracker_flutter/core/configs/injection.dart';
import 'package:gym_tracker_flutter/core/constants/use_case.dart';
import 'package:gym_tracker_flutter/data/services/training_session_service.dart';
import 'package:gym_tracker_flutter/data/use_case/server_failure.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateTrainingSessionUseCase extends UseCase<void, String> {
  @override
  Future<Either<Failure, void>> call(String jsonData) async {
    try {
      await getIt<TrainingSessionService>().createTrainingSession(jsonData);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
