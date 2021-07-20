import 'package:equatable/equatable.dart';

/// Params to pass to be logging
class SignWithEmailParams extends Equatable {
  late final String email;
  late final String password;
  late final String username;

  SignWithEmailParams(
      {required this.username, required this.email, required this.password});
  @override
  List<Object> get props => [this.email, this.password];
}
