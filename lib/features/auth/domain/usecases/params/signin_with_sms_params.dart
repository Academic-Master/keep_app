import 'package:equatable/equatable.dart';
import 'package:keep_app/features/auth/domain/entities/user.dart';
import 'package:keep_app/features/auth/domain/usecases/params/abstract_signin_params.dart';

/// Params to pass to be logging
class SignWithSmsParams extends Equatable implements SignInParams {
  late final String phoneNumber;
  late final int verificationCode;
  late final User user;

  SignWithSmsParams(
      {required this.phoneNumber,
      required this.verificationCode,
      required this.user});
  @override
  List<Object> get props => [];
}
