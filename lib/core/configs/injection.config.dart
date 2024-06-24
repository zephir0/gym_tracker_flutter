// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i11;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/services/auth_service.dart' as _i12;
import '../../data/services/training_log_service.dart' as _i13;
import '../../data/services/training_routine_service.dart' as _i14;
import '../../data/services/training_session_service.dart' as _i15;
import '../../data/services/user_service.dart' as _i16;
import '../../data/use_case/training_log/fetch_previous_training_logs_use_case.dart'
    as _i3;
import '../../data/use_case/training_log/fetch_training_logs_use_case.dart'
    as _i4;
import '../../data/use_case/training_routine/archive_training_routine_use_case.dart'
    as _i5;
import '../../data/use_case/training_routine/create_training_routine_use_case.dart'
    as _i6;
import '../../data/use_case/training_routine/get_training_routines_use_case.dart'
    as _i7;
import '../../data/use_case/training_session/create_training_session_use_case.dart'
    as _i8;
import '../../data/use_case/training_session/delete_training_session_use_case.dart'
    as _i9;
import '../../data/use_case/training_session/fetch_recent_training_sessions_use_case.dart'
    as _i10;
import 'injection.dart' as _i17;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectableModule = _$InjectableModule();
    gh.factory<_i3.FetchPreviousTrainingLogsUseCase>(
        () => _i3.FetchPreviousTrainingLogsUseCase());
    gh.factory<_i4.FetchTrainingLogsUseCase>(
        () => _i4.FetchTrainingLogsUseCase());
    gh.factory<_i5.ArchiveTrainingRoutineUseCase>(
        () => _i5.ArchiveTrainingRoutineUseCase());
    gh.factory<_i6.CreateTrainingRoutineUseCase>(
        () => _i6.CreateTrainingRoutineUseCase());
    gh.factory<_i7.GetTrainingRoutinesUseCase>(
        () => _i7.GetTrainingRoutinesUseCase());
    gh.factory<_i8.CreateTrainingSessionUseCase>(
        () => _i8.CreateTrainingSessionUseCase());
    gh.factory<_i9.DeleteTrainingSessionUseCase>(
        () => _i9.DeleteTrainingSessionUseCase());
    gh.factory<_i10.FetchRecentTrainingSessionsUseCase>(
        () => _i10.FetchRecentTrainingSessionsUseCase());
    gh.singleton<_i11.Dio>(() => injectableModule.provideDio());
    gh.singleton<_i12.AuthService>(() => _i12.AuthService());
    gh.singleton<_i13.TrainingLogService>(() => _i13.TrainingLogService());
    gh.singleton<_i14.TrainingRoutineService>(
        () => _i14.TrainingRoutineService());
    gh.singleton<_i15.TrainingSessionService>(
        () => _i15.TrainingSessionService());
    gh.singleton<_i16.UserService>(() => _i16.UserService());
    return this;
  }
}

class _$InjectableModule extends _i17.InjectableModule {}
