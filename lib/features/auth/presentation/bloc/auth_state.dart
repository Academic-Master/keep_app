part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class IsLoadingState extends AuthState {
  late final message;
  IsLoadingState({required this.message});

  @override
  List<String?> get props => [this.message];
}

class GotSignedInd extends AuthState {
  @override
  List<Object?> get props => [];
}

class FailedToGetSignedIn extends AuthState {
  late final Exception exception;

  FailedToGetSignedIn({required this.exception});
  @override
  List<Object> get props => [exception];
}

class GotLogOut extends AuthState {
  @override
  List<Object> get props => [];
}
