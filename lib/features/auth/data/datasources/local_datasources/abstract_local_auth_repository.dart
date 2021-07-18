import 'package:dartz/dartz.dart';
import 'package:keep_app/core/exceptions/local_database_exception.dart';
import 'package:keep_app/core/models/sucess_operation.dart';
import 'package:keep_app/features/auth/domain/entities/entities_exception/null_user.dart';
import 'package:keep_app/features/auth/domain/entities/user.dart';

abstract class LocalAuthRepository {
  Future<Either<LocalDatabaseException, SuccessOperation>> saveUser(User user);

  /// Getting user info
  Future<Either<LocalDatabaseException, User>> getUser();

  /// Delete user info
  Future<Either<LocalDatabaseException, NullUser>> deleteUser();
}
