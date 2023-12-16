import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/config/get_it_config.dart';
import 'package:gym_tracker_flutter/data/bloc/training_routine/training_routine_event.dart';
import 'package:gym_tracker_flutter/data/bloc/training_routine/training_routine_state.dart';
import 'package:gym_tracker_flutter/data/use_case/training_routine/archive_training_routine_use_case.dart';
import 'package:gym_tracker_flutter/data/use_case/training_routine/create_training_routine_use_case.dart';
import 'package:gym_tracker_flutter/data/use_case/training_routine/get_training_routines_use_case.dart';
import 'package:gym_tracker_flutter/utills/no_parameters.dart';

class TrainingRoutineBloc
    extends Bloc<TrainingRoutineEvent, TrainingRoutineState> {
  TrainingRoutineBloc() : super(TrainingRoutineInitial()) {
    on<FetchTrainingRoutines>(_onFetchTrainingRoutines);
    on<CreateTrainingRoutine>(_onCreateTrainingRoutine);
    on<ArchiveTrainingRoutine>(_onArchiveTrainingRoutine);
  }

  void _onFetchTrainingRoutines(
      FetchTrainingRoutines event, Emitter<TrainingRoutineState> emit) async {
    final getTrainingRoutinesUseCase =
        await getIt<GetTrainingRoutinesUseCase>();
    final routinesOrFailure = await getTrainingRoutinesUseCase(NoParameters());

    routinesOrFailure.fold((failure) => emit(TrainingRoutineError()),
        (routines) => emit(TrainingRoutinesLoaded(routines)));
  }

  void _onCreateTrainingRoutine(
      CreateTrainingRoutine event, Emitter<TrainingRoutineState> emit) async {
    var createTrainingRoutineUseCase =
        await getIt<CreateTrainingRoutineUseCase>();
    var createdOrFailure =
        await createTrainingRoutineUseCase(event.routineData);

    createdOrFailure.fold((failure) => emit(TrainingRoutineCreationFailure()),
        (routines) => emit(TrainingRoutineCreationSuccess()));
  }

  void _onArchiveTrainingRoutine(
      ArchiveTrainingRoutine event, Emitter<TrainingRoutineState> emit) async {
    var archiveTrainingRoutineUseCase =
        await getIt<ArchiveTrainingRoutineUseCase>();
    var archivedOrFailure =
        await archiveTrainingRoutineUseCase(event.routineId);
    archivedOrFailure.fold((failure) => TrainingRoutineError(),
        (routines) => add(FetchTrainingRoutines()));
  }
}
