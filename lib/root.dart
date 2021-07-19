import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keep_app/core/widgets/custom_loader.dart';
import 'package:keep_app/dependency_injection.dart';
import 'package:keep_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:keep_app/features/auth/presentation/pages/login/login.dart';

import 'features/auth/domain/entities/user.dart';

class KeepApp extends StatelessWidget {
  final Box<User> userBox;
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  KeepApp({required this.userBox});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                body: Center(
              child: Text('Error'),
            )),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          FeatureAuthDependencies _featuresDependencies =
              FeatureAuthDependencies(userBox: this.userBox);
          return BlocProvider<AuthBloc>(
              create: (context) => _featuresDependencies.authBloc,
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Keep App',
                theme: ThemeData.light(),
                themeMode: ThemeMode.dark,
                home: Login(),
              ));
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
          home: Scaffold(
            body: CustomLoader('Loading ...'),
          ),
        );
      },
    );
  }
}
