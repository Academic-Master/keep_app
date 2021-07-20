import 'package:dartz/dartz.dart';
import 'package:keep_app/core/models/sucess_operation.dart';
import 'package:keep_app/core/usescases/usescase.dart';
import 'package:keep_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:keep_app/features/auth/domain/usecases/params/save_user_params.dart';

class SaveUser implements UsesCase<SaveUserParams, SuccessOperation> {
  late final AuthRepository _authRepository;

  SaveUser({required AuthRepository authRepository})
      : this._authRepository = authRepository;

  @override
  Future<Either<Exception, SuccessOperation>> trigger(SaveUserParams params) {
    return this._authRepository.saveUser(params);
  }

  @override
  bool get stringify => false;

  @override
  List<Object> get props => [];
}
