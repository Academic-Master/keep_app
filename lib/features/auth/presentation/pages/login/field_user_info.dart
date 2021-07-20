import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep_app/features/auth/domain/usecases/params/save_user_params.dart';
import 'package:keep_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:keep_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:keep_app/features/auth/presentation/widgets/custom_text_field.dart';

class SaveUserInfo extends StatefulWidget {
  final String email;

  SaveUserInfo({required this.email});
  @override
  _SignInWithEmailState createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SaveUserInfo> {
  late final TextEditingController usernameEditingController =
      TextEditingController(text: '');
  // late final TextEditingController passwordEditingController =
  //     TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      CustomTextField(
        fieldType: "Username",
        icon: Icons.phone,
        inputController: usernameEditingController,
        label: 'Username',
      ),
      SizedBox(
        height: 12,
      ),
      // CustomTextField(
      //   fieldType: "text",
      //   icon: Icons.lock_outline,
      //   inputController: passwordEditingController,
      //   label: 'Password',
      // ),
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
    if (this.usernameEditingController.text.isNotEmpty) {
      final _params = SaveUserEvent(
          context: context,
          saveUserParams: SaveUserParams(
              email: widget.email,
              username: this.usernameEditingController.text));
      BlocProvider.of<AuthBloc>(context).add(_params);
    }
  }
}
