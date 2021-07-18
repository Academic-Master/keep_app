import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:keep_app/core/exceptions/no_network_exception.dart';
import 'package:keep_app/core/exceptions/signin_exception.dart';
import 'package:keep_app/core/exceptions/unknow_exception.dart';
import 'package:keep_app/features/auth/data/datasources/remote_datasources/firestore_repository.dart';
import 'package:keep_app/features/auth/data/models/user_model.dart';
import 'package:keep_app/features/auth/domain/entities/user.dart';
import 'package:keep_app/features/auth/domain/entities/entities_exception/null_user.dart';
import 'package:keep_app/features/auth/domain/repositories/auth_repository.dart';
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
  Future<Either<Exception, User>> signInWithEmail(
      SignWithEmailParams params) async {
    try {
      if (!(await this._connectionChecker.hasConnection))
        return left(NoNetworkException());
      final _credentials = await this._auth.signInWithEmailAndPassword(
          email: params.email, password: params.password);
      final _user = UserModel.factory(
          username: _credentials.user!.displayName!,
          phoneNumber: _credentials.user!.phoneNumber!,
          email: _credentials.user!.email!,
          profilePicture: _credentials.user!.photoURL!);
      return Right(_user);
    } on FirebaseAuth.FirebaseAuthException {
      return left(SignInException());
    } on SocketException {
      return left(NoNetworkException());
    } catch (e) {
      return left(UnknowException(message: e.toString()));
    }
  }

  @override
  Future<Either<Exception, User>> signInWithSMS(
      SignWithSmsParams params) async {
    if (!(await this._connectionChecker.hasConnection))
      return left(NoNetworkException());
    try {
      await this._auth.verifyPhoneNumber(
          phoneNumber: params.phoneNumber,
          timeout: const Duration(seconds: 60),
          verificationCompleted: _verifCodeOnComplete,
          verificationFailed: _handleVerifcationFailure,
          codeSent: _handleSentCode,
          codeAutoRetrievalTimeout: _handleAutoRetrivalTimeOut);
      final _user = UserModel.factory(
          username: params.user.username,
          phoneNumber: params.user.phoneNumber,
          email: params.user.email,
          profilePicture: params.user.profilePicture);
      final _userStore =
          await this.saveUserCredentials(_user, this._firebaseFirestore);
      return _userStore.fold((l) => left(l), (r) => right(r));
    } on FirebaseAuth.FirebaseAuthException {
      return left(SignInException());
    } on SocketException {
      return left(NoNetworkException());
    } catch (e) {
      return left(UnknowException(message: e.toString()));
    }
  }

  /// Once verification successufully done
  _verifCodeOnComplete(
      FirebaseAuth.PhoneAuthCredential phoneAuthCredential) async {
    try {
      await this._auth.signInWithCredential(phoneAuthCredential);
    } on SocketException {
      throw NoNetworkException();
    } on FirebaseAuth.FirebaseException {
      throw SignInException();
    } catch (e) {
      return left(UnknowException(message: e.toString()));
    }
  }

  ///TO handle failure of verification
  _handleVerifcationFailure(FirebaseAuth.FirebaseAuthException exception) {}

  _handleSentCode(String verificationId, int? resendToken) {
    print(verificationId);
    print(resendToken);
  }

  _handleAutoRetrivalTimeOut(String verificationId) {
    print(verificationId);
  }

  // get firestoreInstance from outside
  FirebaseFirestore get firestoreInstance => this._firebaseFirestore;
}
