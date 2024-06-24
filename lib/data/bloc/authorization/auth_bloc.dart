import 'package:bloc/bloc.dart';
import 'package:gym_tracker_flutter/core/configs/injection.dart';

import 'package:gym_tracker_flutter/data/services/auth_service.dart';
import 'package:logger/logger.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService = getIt<AuthService>();

  final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  AuthBloc() : super(AuthInitial()) {
    on<LoginAttempt>(_onLoginAttempt);
    on<LogoutAttempt>(_onLogoutAttempt);
    on<RegisterAttempt>(_onRegisterAttempt);
  }

  void _onLoginAttempt(LoginAttempt event, Emitter<AuthState> emit) async {
    logger.i("Login attempt started with username: ${event.username}");
    emit(AuthLoading());
    try {
      bool loggedIn = await authService.attemptLogin(event.username, event.password);
      if (loggedIn) {
        logger.i("Login successful for username: ${event.username}");
        emit(AuthSuccess());
      } else {
        logger.w("Login failed for username: ${event.username}");
        emit(AuthFailure(error: "Failed to authenticate"));
      }
    } catch (e) {
      logger.e("Error during login: $e");
      emit(AuthFailure(error: "Error during login: $e"));
    }
  }

  void _onLogoutAttempt(LogoutAttempt event, Emitter<AuthState> emit) async {
    logger.i("Logout attempt started");
    emit(AuthLoading());
    try {
      await authService.attemptLogout();
      logger.i("Logout successful");
      emit(AuthInitial());
    } catch (e) {
      logger.e("Error during logout: $e");
      emit(AuthFailure(error: "Error during logout: $e"));
    }
  }

  void _onRegisterAttempt(RegisterAttempt event, Emitter<AuthState> emit) async {
    logger.i("Register attempt started with username: ${event.username}, email: ${event.email}");
    emit(AuthLoading());
    try {
      await authService.attemptRegister(event.username, event.email, event.password);
      logger.i("Registration successful for username: ${event.username}");
      emit(AuthSuccess());
    } catch (e) {
      logger.e("Error during registration: $e");
      emit(AuthFailure(error: "Error during registration: $e"));
    }
  }
}
