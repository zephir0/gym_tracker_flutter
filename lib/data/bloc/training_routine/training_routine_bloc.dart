import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/core/configs/injection.dart';
import 'package:gym_tracker_flutter/core/constants/no_parameters.dart';
import 'package:gym_tracker_flutter/data/bloc/training_routine/training_routine_event.dart';
import 'package:gym_tracker_flutter/data/bloc/training_routine/training_routine_state.dart';
import 'package:gym_tracker_flutter/data/use_case/training_routine/archive_training_routine_use_case.dart';
import 'package:gym_tracker_flutter/data/use_case/training_routine/create_training_routine_use_case.dart';
import 'package:gym_tracker_flutter/data/use_case/training_routine/get_training_routines_use_case.dart';
import 'package:logger/logger.dart'; 

class TrainingRoutineBloc
    extends Bloc<TrainingRoutineEvent, TrainingRoutineState> {
  
    final Logger logger = getIt<Logger>();


  TrainingRoutineBloc() : super(TrainingRoutineInitial()) {
    on<FetchTrainingRoutines>(_onFetchTrainingRoutines);
    on<CreateTrainingRoutine>(_onCreateTrainingRoutine);
    on<ArchiveTrainingRoutine>(_onArchiveTrainingRoutine);
  }

  void _onFetchTrainingRoutines(
      FetchTrainingRoutines event, Emitter<TrainingRoutineState> emit) async {
    logger.i("Fetching training routines");
    final getTrainingRoutinesUseCase =
        await getIt<GetTrainingRoutinesUseCase>();
    final routinesOrFailure = await getTrainingRoutinesUseCase(NoParameters());

    routinesOrFailure.fold(
      (failure) {
        logger.e("Failed to fetch training routines: $failure");
        emit(TrainingRoutineError());
      },
      (routines) {
        logger.i("Training routines fetched successfully");
        emit(TrainingRoutinesLoaded(routines));
      },
    );
  }

  void _onCreateTrainingRoutine(
      CreateTrainingRoutine event, Emitter<TrainingRoutineState> emit) async {
    logger.i("Creating training routine with data: ${event.routineData}");
    var createTrainingRoutineUseCase =
        await getIt<CreateTrainingRoutineUseCase>();
    var createdOrFailure =
        await createTrainingRoutineUseCase(event.routineData);

    createdOrFailure.fold(
      (failure) {
        logger.e("Failed to create training routine: $failure");
        emit(TrainingRoutineCreationFailure());
      },
      (routines) {
        logger.i("Training routine created successfully");
        emit(TrainingRoutineCreationSuccess());
      },
    );
  }

  void _onArchiveTrainingRoutine(
      ArchiveTrainingRoutine event, Emitter<TrainingRoutineState> emit) async {
    logger.i("Archiving training routine with id: ${event.routineId}");
    var archiveTrainingRoutineUseCase =
        await getIt<ArchiveTrainingRoutineUseCase>();
    var archivedOrFailure =
        await archiveTrainingRoutineUseCase(event.routineId);
    archivedOrFailure.fold(
      (failure) {
        logger.e("Failed to archive training routine: $failure");
        emit(TrainingRoutineError());
      },
      (routines) {
        logger.i("Training routine archived successfully");
        add(FetchTrainingRoutines());
      },
    );
  }
}
