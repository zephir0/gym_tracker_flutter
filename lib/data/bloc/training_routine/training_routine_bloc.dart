import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/training_routine/training_routine_event.dart';
import 'package:gym_tracker_flutter/data/bloc/training_routine/training_routine_state.dart';
import 'package:gym_tracker_flutter/data/services/training_routine_service.dart';

import '../../models/training_routine.dart';

class TrainingRoutineBloc
    extends Bloc<TrainingRoutineEvent, TrainingRoutineState> {
  final TrainingRoutineService service;

  TrainingRoutineBloc(this.service) : super(TrainingRoutineInitial()) {
    on<FetchTrainingRoutines>(_onFetchTrainingRoutines);
    on<CreateTrainingRoutine>(_onCreateTrainingRoutine);
    on<ArchiveTrainingRoutine>(_onArchiveTrainingRoutine);
  }

  void _onFetchTrainingRoutines(
      FetchTrainingRoutines event, Emitter<TrainingRoutineState> emit) async {
    try {
      List<TrainingRoutine> routines = await service.getTrainingRoutines();
      emit(TrainingRoutinesLoaded(routines));
    } catch (e) {
      emit(TrainingRoutineError());
    }
  }

  void _onCreateTrainingRoutine(
      CreateTrainingRoutine event, Emitter<TrainingRoutineState> emit) async {
    bool success = await service.createTrainingRoutine(event.routineData);
    if (success) {
      emit(TrainingRoutineCreationSuccess());
      add(FetchTrainingRoutines());
    } else {
      emit(TrainingRoutineCreationFailure());
    }
  }

  void _onArchiveTrainingRoutine(
      ArchiveTrainingRoutine event, Emitter<TrainingRoutineState> emit) async {
    await service.archiveTrainingRoutine(event.routineId);

    add(FetchTrainingRoutines());
  }
}
