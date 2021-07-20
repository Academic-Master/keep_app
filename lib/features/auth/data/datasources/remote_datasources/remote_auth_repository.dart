import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:keep_app/core/exceptions/no_network_exception.dart';
import 'package:keep_app/core/exceptions/signin_exception.dart';
import 'package:keep_app/core/exceptions/unknow_exception.dart';
import 'package:keep_app/core/models/sucess_operation.dart';
import 'package:keep_app/features/auth/data/datasources/remote_datasources/firestore_repository.dart';
import 'package:keep_app/features/auth/data/models/user_model.dart';
import 'package:keep_app/features/auth/domain/entities/entities_exception/null_user.dart';
import 'package:keep_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:keep_app/features/auth/domain/usecases/params/save_user_params.dart';
import 'package:keep_app/features/auth/domain/usecases/params/signin_with_sms_params.dart';
import 'package:keep_app/features/auth/domain/usecases/params/signin_with_email_params.dart';
import 'package:keep_app/features/auth/domain/usecases/params/log_out_params.dart';

class RemoteAuthRepository with FireStoreRepository implements AuthRepository {
  late final DataConnectionChecker _connectionChecker;
  late final FirebaseAuth.FirebaseAuth _auth;
  late final FirebaseFirestore _firebaseFirestore;

  RemoteAuthRepository(
      {required FirebaseAuth.FirebaseAuth auth,
      required DataConnectionChecker connectionChecker,
      required FirebaseFirestore firestoreInstance})
      : this._auth = auth,
        this._connectionChecker = connectionChecker,
        this._firebaseFirestore = firestoreInstance;

  @override
  Future<Either<Exception, NullUser>> logOut(LogOutParams params) async {
    try {
      if (!(await this._connectionChecker.hasConnection))
        return left(NoNetworkException());
      await this._auth.signOut();
      return right(NullUser());
    } catch (e) {
      return left(UnknowException(message: e.toString()));
    }
  }

  @override
  Future<Either<Exception, SuccessOperation>> signInWithEmail(
      SignWithEmailParams params) async {
    try {
      if (!(await this._connectionChecker.hasConnection))
        return left(NoNetworkException());
      if ((await (this
                      ._firebaseFirestore
                      .collection('users')
                      .where('email', isEqualTo: params.email))
                  .get())
              .docs
              .length >=
          1) {
        // User already exists
        await this._auth.signInWithEmailAndPassword(
            email: params.email, password: params.password);
      } else {
        await this._auth.createUserWithEmailAndPassword(
            email: params.email, password: params.password);
        final _user = UserModel(username: params.username, email: params.email);
        await this._auth.signInWithEmailAndPassword(
            email: params.email, password: params.password);
        this.saveUserCredentials(_user, firestoreInstance);
      }
      return Right(SuccessOperation());
    } on FirebaseAuth.FirebaseAuthException {
      return left(SignInException());
    } on SocketException {
      return left(NoNetworkException());
    } catch (e) {
      return left(UnknowException(message: e.toString()));
    }
  }

  // get firestoreInstance from outside
  FirebaseFirestore get firestoreInstance => this._firebaseFirestore;

  @override
  Future<Either<Exception, SuccessOperation>> saveUser(SaveUserParams params) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, SuccessOperation>> signInWithSMS(
      SignWithSmsParams params) {
    // TODO: implement signInWithSMS
    throw UnimplementedError();
  }
}
