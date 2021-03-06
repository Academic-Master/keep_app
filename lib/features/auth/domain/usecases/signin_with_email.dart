import 'package:dartz/dartz.dart';
import 'package:keep_app/core/models/sucess_operation.dart';
import 'package:keep_app/core/usescases/usescase.dart';
import 'package:keep_app/features/auth/domain/repositories/auth_repository.dart';

import 'params/signin_with_email_params.dart';

class SignInWithEmail
    implements UsesCase<SignWithEmailParams, SuccessOperation> {
  late final AuthRepository _authRepository;

  SignInWithEmail({required AuthRepository authRepository})
      : this._authRepository = authRepository;

  @override
  Future<Either<Exception, SuccessOperation>> trigger(
      SignWithEmailParams params) {
    return this._authRepository.signInWithEmail(params);
  }

  @override
  bool get stringify => false;

  @override
  List<Object> get props => [];
}
