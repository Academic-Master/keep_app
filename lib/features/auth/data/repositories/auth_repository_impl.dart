import 'package:keep_app/features/auth/data/datasources/local_datasources/abstract_local_auth_repository.dart';
import 'package:keep_app/features/auth/data/datasources/remote_datasources/remote_auth_repository.dart';
import 'package:keep_app/features/auth/domain/entities/entities_exception/null_user.dart';
import 'package:dartz/dartz.dart';
import 'package:keep_app/features/auth/domain/entities/user.dart' as User;
import 'package:keep_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:keep_app/features/auth/domain/usecases/params/signin_with_sms_params.dart';
import 'package:keep_app/features/auth/domain/usecases/params/signin_with_email_params.dart';
import 'package:keep_app/features/auth/domain/usecases/params/log_out_params.dart';

class AuthRepositoryImpl implements AuthRepository {
  late final LocalAuthRepository _localAuthRepository;
  late final RemoteAuthRepository _remoteAuthRepository;

  AuthRepositoryImpl(
      {required LocalAuthRepository localAuthRepository,
      required RemoteAuthRepository remoteAuthRepository})
      : this._localAuthRepository = localAuthRepository,
        this._remoteAuthRepository = remoteAuthRepository;

  @override
  Future<Either<Exception, NullUser>> logOut(LogOutParams params) async {
    final _response = await this._remoteAuthRepository.logOut(params);
    if (_response.isRight()) {
      final _response = await this._localAuthRepository.deleteUser();
      if (_response.isRight()) {
        return right(NullUser());
      }
      return left(_response.fold((l) => l, (r) => Exception()));
    }
    return left(_response.fold((l) => l, (r) => Exception()));
  }

  @override
  Future<Either<Exception, User.User>> signInWithEmail(
      SignWithEmailParams params) async {
    final _response = await this._remoteAuthRepository.signInWithEmail(params);
    if (_response.isRight()) {
      final User.User _user = User.User(
          username: params.username,
          phoneNumber: params.phone,
          email: params.email);
      final _response = await this._localAuthRepository.saveUser(_user);
      if (_response.isRight()) {
        return right(_user);
      }
      return left(_response.fold((l) => l, (r) => Exception()));
    }
    return left(_response.fold((l) => l, (r) => Exception()));
  }

  @override
  Future<Either<Exception, User.User>> signInWithSMS(
      SignWithSmsParams params) async {
    final _response = await this._remoteAuthRepository.signInWithSMS(params);
    if (_response.isRight()) {
      final _response = await this._localAuthRepository.saveUser(params.user);
      if (_response.isRight()) {
        return right(params.user);
      }
      return left(_response.fold((l) => l, (r) => Exception()));
    }
    return left(_response.fold((l) => l, (r) => Exception()));
  }
}
