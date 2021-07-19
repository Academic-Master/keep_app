import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keep_app/features/auth/data/datasources/local_datasources/abstract_local_auth_repository.dart';
import 'package:keep_app/features/auth/data/datasources/local_datasources/local_auth_repository_impl.dart';
import 'package:keep_app/features/auth/data/datasources/remote_datasources/remote_auth_repository.dart';
import 'package:keep_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:keep_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:keep_app/features/auth/presentation/bloc/auth_bloc.dart';

import 'features/auth/domain/entities/user.dart';
import 'features/auth/domain/usecases/log_out.dart';
import 'features/auth/domain/usecases/signin_with_email.dart';
import 'features/auth/domain/usecases/signin_with_sms.dart';

//// Feature Auth dependencies
class FeatureAuthDependencies {
  ///Local repository dependencies
  late final Box<User> box;
  late final String userKey;

  // Remote repository dependencies
  late final DataConnectionChecker dataConnectionChecker;
  late final FirebaseAuth.FirebaseAuth firebaseAuth;
  late final FirebaseFirestore firebaseFirestore;

  // Auth repository dependencies
  late final LocalAuthRepository localAuthRepository;
  late final RemoteAuthRepository remoteAuthRepository;
  late final AuthRepository authRepository;

  // Bloc dependencies (Usescases)
  late final SignInWithSMS signInWithSMS;
  late final SignInWithEmail signInWithEmail;
  late final LogOut logOut;
  late final AuthBloc authBloc;

  FeatureAuthDependencies({required Box<User> userBox}) {
    ///Local repository dependencies instanciations
    this.userKey = 'currentUser';
    this.box = userBox;
    // Remote repository dependencies instantiations
    this.dataConnectionChecker = DataConnectionChecker();
    this.firebaseAuth = FirebaseAuth.FirebaseAuth.instance;
    this.firebaseFirestore = FirebaseFirestore.instance;

    // Auth repository dependencies instanciations
    this.localAuthRepository =
        LocalAuthRepositoryImpl(box: this.box, userKey: userKey);
    this.remoteAuthRepository = RemoteAuthRepository(
        auth: this.firebaseAuth,
        connectionChecker: this.dataConnectionChecker,
        firestoreInstance: this.firebaseFirestore);
    this.authRepository = AuthRepositoryImpl(
        localAuthRepository: localAuthRepository,
        remoteAuthRepository: remoteAuthRepository);

    // Bloc dependencies (Usescases) instantiations
    this.signInWithSMS = SignInWithSMS(authRepository: authRepository);
    this.signInWithEmail = SignInWithEmail(authRepository: authRepository);
    this.logOut = LogOut(authRepository: authRepository);
    this.authBloc = AuthBloc(
        logOut: logOut,
        signInWithEmail: signInWithEmail,
        signInWithSMS: signInWithSMS);
  }
}
