import 'package:equatable/equatable.dart';

/// Params to pass to be logging
class SignWithSmsParams extends Equatable {
  late final String phoneNumber;
  late final int verificationCode;

  SignWithSmsParams(
      {required this.phoneNumber, required this.verificationCode});
  @override
  List<Object> get props => [];
}
