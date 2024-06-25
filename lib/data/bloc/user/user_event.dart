import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchUserName extends UserEvent {}

class UpdatePassword extends UserEvent {
  final String oldPassword;
  final String newPassword;

  UpdatePassword({required this.oldPassword, required this.newPassword});

  @override
  List<Object> get props => [oldPassword, newPassword];
}

class UpdateEmail extends UserEvent {
  final String newEmail;

  UpdateEmail({required this.newEmail});

  @override
  List<Object> get props => [newEmail];
}

class UpdateUsername extends UserEvent {
  final String newUsername;

  UpdateUsername({required this.newUsername});

  @override
  List<Object> get props => [newUsername];
}
