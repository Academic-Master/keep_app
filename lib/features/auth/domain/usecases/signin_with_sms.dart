import 'package:dartz/dartz.dart';
import 'package:keep_app/core/models/sucess_operation.dart';
import 'package:keep_app/core/usescases/usescase.dart';
import 'package:keep_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:keep_app/features/auth/domain/usecases/params/signin_with_sms_params.dart';

class SignInWithSMS implements UsesCase<SignWithSmsParams, SuccessOperation> {
  late final AuthRepository _authRepository;

  SignInWithSMS({required AuthRepository authRepository})
      : this._authRepository = authRepository;

  @override
  Future<Either<Exception, SuccessOperation>> trigger(
      SignWithSmsParams params) {
    return this._authRepository.signInWithSMS(params);
  }

  @override
  bool get stringify => false;

  @override
  List<Object> get props => [];
}
