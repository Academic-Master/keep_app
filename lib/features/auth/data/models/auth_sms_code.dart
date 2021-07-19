import 'package:equatable/equatable.dart';

class AuthSmsCode extends Equatable {
  late final int code;
  AuthSmsCode({required this.code});
  @override
  List<Object> get props => throw UnimplementedError();
}
