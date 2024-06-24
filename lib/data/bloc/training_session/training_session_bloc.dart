import 'package:bloc/bloc.dart';
import 'package:gym_tracker_flutter/core/configs/injection.dart';
import 'package:gym_tracker_flutter/core/constants/no_parameters.dart';
import 'package:gym_tracker_flutter/data/bloc/training_session/training_session_event.dart';
import 'package:gym_tracker_flutter/data/bloc/training_session/training_session_state.dart';
import 'package:gym_tracker_flutter/data/use_case/training_session/create_training_session_use_case.dart';
import 'package:gym_tracker_flutter/data/use_case/training_session/delete_training_session_use_case.dart';
import 'package:gym_tracker_flutter/data/use_case/training_session/fetch_recent_training_sessions_use_case.dart';
import 'package:logger/logger.dart'; 

class TrainingSessionBloc
    extends Bloc<TrainingSessionEvent, TrainingSessionState> {
  
    final Logger logger = getIt<Logger>();

  TrainingSessionBloc() : super(TrainingSessionInitial()) {
    on<FetchTrainingSessions>(_onFetchTrainingSessions);
    on<CreateTrainingSession>(_onCreateTrainingSession);
    on<DeleteTrainingSession>(_onDeleteTrainingSession);
  }

  Future<void> _onFetchTrainingSessions(
    FetchTrainingSessions event,
    Emitter<TrainingSessionState> emit,
  ) async {
    logger.i("Fetching training sessions");
    final fetchRecentTrainingSessionsUseCase =
        getIt<FetchRecentTrainingSessionsUseCase>();
    final sessionsOrFailure =
        await fetchRecentTrainingSessionsUseCase(NoParameters());

    sessionsOrFailure.fold(
      (failure) {
        logger.e("Failed to fetch training sessions: $failure");
        emit(TrainingSessionError());
      },
      (sessions) {
        logger.i("Training sessions fetched successfully");
        emit(TrainingSessionLoaded(sessions));
      },
    );
  }

  Future<void> _onCreateTrainingSession(
    CreateTrainingSession event,
    Emitter<TrainingSessionState> emit,
  ) async {
    logger.i("Creating training session with data: ${event.jsonData}");
    final createTrainingSessionUseCase = getIt<CreateTrainingSessionUseCase>();
    await createTrainingSessionUseCase(event.jsonData);
    logger.i("Training session created successfully");
    add(FetchTrainingSessions());
  }

  Future<void> _onDeleteTrainingSession(
    DeleteTrainingSession event,
    Emitter<TrainingSessionState> emit,
  ) async {
    logger.i("Deleting training session with id: ${event.sessionId}");
    final deleteTrainingSessionUseCase = getIt<DeleteTrainingSessionUseCase>();
    await deleteTrainingSessionUseCase(event.sessionId);
    logger.i("Training session deleted successfully");
    add(FetchTrainingSessions());
  }
}
