import 'package:equatable/equatable.dart';

/// Params to pass to be logging
class SignWithEmailParams extends Equatable {
  late final String email;
  late final String username;
  late final String password;
  final String phone = '';

  SignWithEmailParams({required this.email, required this.password});
  @override
  List<Object> get props => [this.email, this.password];
}
