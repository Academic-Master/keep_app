import 'package:equatable/equatable.dart';
import 'package:keep_app/features/auth/domain/entities/user.dart';
import 'package:keep_app/features/auth/domain/usecases/params/abstract_signin_params.dart';

/// Params to pass to be logging
class SignWithEmailParams extends Equatable implements SignInParams {
  late final String email;
  late final String password;
  late final User user;

  SignWithEmailParams(
      {required this.user, required this.email, required this.password});
  @override
  List<Object> get props => [this.email, this.password];
}
