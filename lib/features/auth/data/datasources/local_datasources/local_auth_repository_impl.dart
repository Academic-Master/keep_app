import 'package:hive/hive.dart';
import 'package:keep_app/core/models/sucess_operation.dart';
import 'package:keep_app/core/exceptions/local_database_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:keep_app/features/auth/data/datasources/local_datasources/abstract_local_auth_repository.dart';
import 'package:keep_app/features/auth/domain/entities/user.dart';
import 'package:keep_app/features/auth/domain/entities/entities_exception/null_user.dart';

class LocalAuthRepositoryImpl implements LocalAuthRepository {
  late final Box<User> _box;
  late final String _userKey;

  LocalAuthRepositoryImpl({required Box<User> box, required String userKey})
      : this._box = box,
        this._userKey = userKey;

  @override
  Future<Either<LocalDatabaseException, NullUser>> deleteUser() async {
    try {
      await this._box.delete(_userKey);
      return right(NullUser());
    } catch (e) {
      return left(LocalDatabaseException(error: e.toString()));
    }
  }

  @override
  Future<Either<LocalDatabaseException, User>> getUser() async {
    try {
      if (_box.containsKey(_userKey)) {
        final _user = this._box.get(_userKey);
        return right(_user!);
      }
      return left(LocalDatabaseException(error: "NO USER SAVED"));
    } catch (e) {
      return left(LocalDatabaseException(error: e.toString()));
    }
  }

  @override
  Future<Either<LocalDatabaseException, SuccessOperation>> saveUser(
      User user) async {
    try {
      if (!_box.containsKey(_userKey)) {
        await _box.put(_userKey, user);
        return right(SuccessOperation());
      }
      return right(SuccessOperation());
    } catch (e) {
      return left(LocalDatabaseException(error: e.toString()));
    }
  }
}
