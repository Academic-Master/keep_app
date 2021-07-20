part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {}

/// Will use add Event at the end of every bloc event to avoid name conflit with usescases

class SignInWithEmailEvent extends AuthEvent {
  late final BuildContext context;
  late final SignWithEmailParams signWithEmailParams;

  SignInWithEmailEvent(
      {required this.context, required this.signWithEmailParams});
  @override
  List<Object> get props => [signWithEmailParams];
}

class SignInWithSMSEvent extends AuthEvent {
  late final BuildContext context;
  final SignWithSmsParams signInWithSMSParams;

  SignInWithSMSEvent(
      {required this.context, required this.signInWithSMSParams});
  @override
  List<Object> get props => [signInWithSMSParams];
}

class SaveUserEvent extends AuthEvent {
  late final BuildContext context;
  late final SaveUserParams saveUserParams;

  SaveUserEvent({required this.context, required this.saveUserParams});
  @override
  List<Object> get props => [this.saveUserParams];
}

class LogOutEvent extends AuthEvent {
  late final BuildContext context;
  late final LogOutParams logOutParams;

  LogOutEvent({required this.context, required this.logOutParams});
  @override
  List<Object> get props => [];
}
