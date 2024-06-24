abstract class AuthEvent {}

class LoginAttempt extends AuthEvent {
  final String username;
  final String password;

  LoginAttempt({required this.username, required this.password});
}

class LogoutAttempt extends AuthEvent {}

class RegisterAttempt extends AuthEvent {
  final String username;
  final String email;
  final String password;

  RegisterAttempt({
    required this.username,
    required this.email,
    required this.password,
  });
}
