import 'package:dartz/dartz.dart';
import 'package:keep_app/core/usescases/usescase.dart';
import 'package:keep_app/features/auth/domain/entities/user.dart';
import 'package:keep_app/features/auth/domain/repositories/auth_repository.dart';

import 'params/signin_with_email_params.dart';

class SignInWithEmail implements UsesCase<SignWithEmailParams, User> {
  late final AuthRepository _authRepository;

  SignInWithEmail({required AuthRepository authRepository})
      : this._authRepository = authRepository;

  @override
  Future<Either<Exception, User>> trigger(SignWithEmailParams params) {
    return this._authRepository.signInWithEmail(params);
  }

  @override
  bool get stringify => false;

  @override
  List<Object> get props => [];
}
