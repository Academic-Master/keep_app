import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep_app/core/widgets/custom_loader.dart';
import 'package:keep_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'sigin_with_email.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final StreamController<int> _switchController = StreamController.broadcast();
  String email = '';

  @override
  void dispose() {
    this._switchController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<AuthBloc, AuthState>(builder: (context, data) {
        if (data is IsLoadingState) {
          return CustomLoader('Loading ...');
        }
        return Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.all(25.0),
            height: MediaQuery.of(context).size.height * .8,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.pink[50]!, offset: Offset(1, 2), blurRadius: 7)
            ], borderRadius: BorderRadius.circular(25), color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Get Login for more\nfeatures 🖖',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                  if (state is IsLoadingState)
                    showDialog(
                        context: context,
                        builder: (context) => CustomLoader('Loading ...'));
                  else if (state is GotSignedInd) {
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                  return SignInWithEmail();
                })
              ],
            ),
          ),
        );
      }),
    );
  }
}
