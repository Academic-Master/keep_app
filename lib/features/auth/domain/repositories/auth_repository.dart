import 'package:dartz/dartz.dart';
import 'package:keep_app/features/auth/domain/entities/entities_exception/null_user.dart';
import 'package:keep_app/features/auth/domain/entities/user.dart';
import 'package:keep_app/features/auth/domain/usecases/params/log_out_params.dart';
import 'package:keep_app/features/auth/domain/usecases/params/signin_with_email_params.dart';
import 'package:keep_app/features/auth/domain/usecases/params/signin_with_sms_params.dart';

abstract class AuthRepository {
  ///For signin with phone
  Future<Either<Exception, User>> signInWithSMS(SignWithSmsParams params);

  ///For signin with email
  Future<Either<Exception, User>> signInWithEmail(SignWithEmailParams params);

  ///Logout
  Future<Either<Exception, NullUser>> logOut(LogOutParams params);
}
