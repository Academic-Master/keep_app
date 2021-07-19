import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep_app/features/auth/domain/usecases/params/signin_with_email_params.dart';
import 'package:keep_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:keep_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:keep_app/features/auth/presentation/widgets/custom_text_field.dart';

class SignInWithEmail extends StatefulWidget {
  @override
  _SignInWithEmailState createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> {
  late final TextEditingController emailEditingController =
      TextEditingController(text: '');
  late final TextEditingController passwordEditingController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
        onPressed: () => _requestSignIn(context),
      )
    ]);
  }

  _requestSignIn(BuildContext context) async {
    final _params = SignWithEmailParams(
        email: this.emailEditingController.text,
        password: this.passwordEditingController.text);

    BlocProvider.of<AuthBloc>(context)
        .add(SignInWithEmailEvent(signWithEmailParams: _params));
  }
}
