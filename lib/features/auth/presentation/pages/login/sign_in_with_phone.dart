import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep_app/features/auth/domain/usecases/params/signin_with_sms_params.dart';
import 'package:keep_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:keep_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:keep_app/features/auth/presentation/widgets/custom_text_field.dart';

class SignInWithPhone extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignInWithPhoneState();
}

class SignInWithPhoneState extends State<SignInWithPhone> {
  late final TextEditingController phoneEditingController =
      TextEditingController(text: '');
  late final TextEditingController otpEditingController =
      TextEditingController(text: '');
  bool isSent = false;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      CustomTextField(
        fieldType: "phone",
        icon: Icons.phone,
        inputController: phoneEditingController,
        label: 'Phone Number',
      ),
      SizedBox(
        height: 12,
      ),
      isSent
          ? CustomTextField(
              fieldType: "OTP",
              icon: Icons.phone,
              inputController: otpEditingController,
              label: 'Phone Number',
            )
          : Container(),
      CustomButton(
        label: 'Request OTP',
        isSelected: true,
        withShadow: false,
        onPressed: () async => _requestOtp(context),
      )
    ]);
  }

  _requestOtp(BuildContext context) async {
    if (this.phoneEditingController.text.isNotEmpty) {
      final _params = SignWithSmsParams(
        verificationCode: 0,
        phoneNumber: this.phoneEditingController.text,
      );
      BlocProvider.of<AuthBloc>(context).add(
          SignInWithSMSEvent(signInWithSMSParams: _params, context: context));
    }
  }
}
