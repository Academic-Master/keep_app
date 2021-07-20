import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:keep_app/core/constants/messages/messages.dart';
import 'package:keep_app/features/auth/domain/usecases/log_out.dart';
import 'package:keep_app/features/auth/domain/usecases/params/log_out_params.dart';
import 'package:keep_app/features/auth/domain/usecases/params/save_user_params.dart';
import 'package:keep_app/features/auth/domain/usecases/params/signin_with_email_params.dart';
import 'package:keep_app/features/auth/domain/usecases/params/signin_with_sms_params.dart';
import 'package:keep_app/features/auth/domain/usecases/signin_with_email.dart';
import 'package:keep_app/features/auth/domain/usecases/signin_with_sms.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final SignInWithSMS signInWithSMS;
  late final SignInWithEmail signInWithEmail;
  late final LogOut logOut;

  AuthBloc(
      {required this.logOut,
      required this.signInWithEmail,
      required this.signInWithSMS})
      : super(AuthInitial());
  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is SignInWithEmailEvent) {
      yield IsLoadingState(message: Messages.isLoading);
      // Sigin with email
      final _response =
          await this.signInWithEmail.trigger(event.signWithEmailParams);
      yield _response.fold((l) {
        return FailedToGetSignedIn(exception: l);
      }, (r) {
        Navigator.pushReplacementNamed(event.context, '/login');
        return GotSignedInd();
      });
    } else if (event is SignInWithSMSEvent) {
      yield IsLoadingState(message: Messages.isLoading);
      // Sigin with email
      final _response =
          await this.signInWithSMS.trigger(event.signInWithSMSParams);
      yield _response.fold(
          (l) => FailedToGetSignedIn(exception: l), (r) => GotSignedInd());
    } else if (event is LogOutEvent) {
      final _response = await this.logOut.trigger(event.logOutParams);
      yield _response.fold(
          (l) => FailedToGetSignedIn(exception: l), (r) => GotLogOut());
    }
  }
}
