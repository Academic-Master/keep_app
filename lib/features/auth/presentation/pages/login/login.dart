import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep_app/core/widgets/custom_loader.dart';
import 'package:keep_app/features/auth/domain/entities/user.dart';
import 'package:keep_app/features/auth/domain/usecases/params/signin_with_sms_params.dart';
import 'package:keep_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:keep_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:keep_app/features/auth/presentation/widgets/custom_text_field.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController phoneEditingController =
      TextEditingController(text: '');
  late final TextEditingController otpEditingController =
      TextEditingController(text: '');
  late final TextEditingController emailEditingController =
      TextEditingController(text: '');
  late final TextEditingController passwordEditingController =
      TextEditingController(text: '');

  final StreamController<int> _switchController = StreamController.broadcast()
    ..add(0);

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
                          ? _buildPhoneForm()
                          : _buildEmailForm();
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
    print(index);
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

  Widget _buildPhoneForm() =>
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        CustomTextField(
          fieldType: "phone",
          icon: Icons.phone,
          inputController: phoneEditingController,
          label: 'Phone Number',
        ),
        SizedBox(
          height: 12,
        ),
        CustomTextField(
          fieldType: "OTP",
          icon: Icons.phone,
          inputController: otpEditingController,
          label: 'Phone Number',
        ),
        CustomButton(
          label: 'Request OTP',
          isSelected: true,
          withShadow: false,
          onPressed: () async => _requestOtp(context),
        )
      ]);

  _requestOtp(BuildContext context) async {
    final _params = SignWithSmsParams(
        verificationCode: 0,
        phoneNumber: this.phoneEditingController.text,
        user: User(
            username: "Obed",
            phoneNumber: this.phoneEditingController.text,
            email: '',
            profilePicture: ''));
    BlocProvider.of<AuthBloc>(context)
        .add(SignInWithSMSEvent(signInWithSMSParams: _params));
  }

  Widget _buildEmailForm() =>
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        CustomTextField(
          fieldType: "email",
          icon: Icons.phone,
          inputController: emailEditingController,
          label: 'Email Number',
        ),
        SizedBox(
          height: 12,
        ),
        CustomTextField(
          fieldType: "text",
          icon: Icons.lock_outline,
          inputController: passwordEditingController,
          label: 'Password',
        ),
        SizedBox(
          height: 12,
        ),
        CustomButton(
          label: 'Login',
          isSelected: true,
          withShadow: false,
          onPressed: () {},
        )
      ]);
}
