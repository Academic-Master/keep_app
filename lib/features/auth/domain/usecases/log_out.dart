import 'package:dartz/dartz.dart';
import 'package:keep_app/core/usescases/usescase.dart';
import 'package:keep_app/features/auth/domain/entities/entities_exception/null_user.dart';
import 'package:keep_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:keep_app/features/auth/domain/usecases/params/log_out_params.dart';

class LogOut implements UsesCase<LogOutParams, NullUser> {
  late final AuthRepository _authRepository;

  LogOut({required AuthRepository authRepository})
      : this._authRepository = authRepository;

  @override
  Future<Either<Exception, NullUser>> trigger(LogOutParams params) {
    return this._authRepository.logOut(params);
  }

  @override
  bool get stringify => false;

  @override
  List<Object> get props => [];
}
