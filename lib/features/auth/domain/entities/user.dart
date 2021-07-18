import 'package:equatable/equatable.dart';

import 'entities_exception/user_exception.dart';

/// User definition

class User extends Equatable {
  late final String username;
  late final String phoneNumber;
  late final String email;

  /// User picture got from providers
  late final String profilePicture;

  User(
      {required String username,
      required String phoneNumber,
      required String email,
      required String profilePicture}) {
    //TODO
    if (phoneNumber.isEmpty && profilePicture.isEmpty && username.isEmpty)
      throw UserException();
    else {
      this.phoneNumber = phoneNumber;
      this.username = username;
      this.email = email;
      this.profilePicture = profilePicture;
    }
  }

  @override
  List<String> get props =>
      [this.phoneNumber, this.profilePicture, this.username];
}
