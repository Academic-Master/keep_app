import 'package:equatable/equatable.dart';

class SendBySmsTokenParams extends Equatable {
  late final String phoneNumber;
  SendBySmsTokenParams({required this.phoneNumber});

  @override
  List<Object> get props => throw UnimplementedError();
}
