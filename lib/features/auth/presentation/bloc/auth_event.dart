part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {}

/// Will use add Event at the end of every bloc event to avoid name conflit with usescases

class SignInWithEmailEvent extends AuthEvent {
  final SignWithEmailParams signWithEmailParams;

  SignInWithEmailEvent({required this.signWithEmailParams});
  @override
  List<Object> get props => [signWithEmailParams];
}

class SignInWithSMSEvent extends AuthEvent {
  final SignWithSmsParams signInWithSMSParams;

  SignInWithSMSEvent({required this.signInWithSMSParams});
  @override
  List<Object> get props => [signInWithSMSParams];
}

class LogOutEvent extends AuthEvent {
  late final LogOutParams logOutParams;

  LogOutEvent({required this.logOutParams});
  @override
  List<Object> get props => [];
}
