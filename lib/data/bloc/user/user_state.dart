import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final String username;

  UserLoaded({required this.username});

  @override
  List<Object> get props => [username];
}

class UserUpdated extends UserState {}

class UserError extends UserState {
  final String errorMessage;

  UserError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
