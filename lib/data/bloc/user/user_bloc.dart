import 'package:bloc/bloc.dart';
import 'package:gym_tracker_flutter/core/configs/injection.dart';
import 'package:gym_tracker_flutter/data/services/user_service.dart';

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService _userService = getIt<UserService>();

  UserBloc() : super(UserInitial()) {
    on<FetchUserName>(_onFetchUserName);
    on<UpdatePassword>(_onUpdatePassword);
    on<UpdateEmail>(_onUpdateEmail);
    on<UpdateUsername>(_onUpdateUsername);
  }

  void _onFetchUserName(FetchUserName event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final username = await _userService.fetchUserInfoFromJson();
      emit(UserLoaded(username: username));
    } catch (e) {
      emit(UserError(errorMessage: "Failed to fetch username: $e"));
    }
  }

  void _onUpdatePassword(UpdatePassword event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await _userService.attemptChangePassword(event.oldPassword, event.newPassword);
      emit(UserUpdated());
    } catch (e) {
      emit(UserError(errorMessage: "Failed to update password: $e"));
    }
  }

  void _onUpdateEmail(UpdateEmail event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await _userService.attemptChangeEmail(event.newEmail);
      emit(UserUpdated());
    } catch (e) {
      emit(UserError(errorMessage: "Failed to update email: $e"));
    }
  }

  void _onUpdateUsername(UpdateUsername event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await _userService.attemptChangeUsername(event.newUsername);
      emit(UserUpdated());
    } catch (e) {
      emit(UserError(errorMessage: "Failed to update username: $e"));
    }
  }
}
