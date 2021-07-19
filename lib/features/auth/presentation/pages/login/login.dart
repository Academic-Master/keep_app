import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep_app/core/widgets/custom_loader.dart';
import 'package:keep_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:keep_app/features/auth/presentation/widgets/custom_button.dart';

import 'sigin_with_email.dart';
import 'sign_in_with_phone.dart';

class Login extends StatelessWidget {
  final StreamController<int> _switchController = StreamController.broadcast()
    ..add(0);

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
            height: 430,
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
                StreamBuilder<int>(
                    initialData: 0,
                    stream: this._switchController.stream,
                    builder: (context, data) {
                      return _buildButtonBar(context, data.data!);
                    }),
                SizedBox(
                  height: 25,
                ),
                StreamBuilder<int>(
                    initialData: 0,
                    stream: this._switchController.stream,
                    builder: (context, data) {
                      print(data.data);
                      return data.data == 0
                          ? SignInWithPhone()
                          : SignInWithEmail();
                    })
              ],
            ),
          ),
        );
      }),
    );
  }

  _switchFormView(int index) {
    this._switchController.add(index);
  }

  Widget _buildButtonBar(BuildContext context, int index) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Container(
          width: MediaQuery.of(context).size.width * .35,
          height: 40,
          child: SizedBox.expand(
              child: CustomButton(
                  label: 'Email',
                  withShadow: false,
                  onPressed: () => _switchFormView(1),
                  isSelected: index == 1 ? true : false))),
      Container(
          width: MediaQuery.of(context).size.width * .35,
          height: 40,
          child: SizedBox.expand(
              child: CustomButton(
            isSelected: index == 0 ? true : false,
            withShadow: true,
            label: 'Phone',
            onPressed: () => _switchFormView(0),
          ))),
    ]);
  }
}
