import 'package:keep_app/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel(
      {required String username,
      required String phoneNumber,
      required String email,
      required String profilePicture})
      : super(
            email: email,
            phoneNumber: phoneNumber,
            profilePicture: profilePicture,
            username: username);

  factory UserModel.factory(
          {required String username,
          required String phoneNumber,
          required String email,
          required String profilePicture}) =>
      UserModel(
          username: username,
          phoneNumber: phoneNumber,
          email: email,
          profilePicture: profilePicture);

  Map<String, String> toJson() => {
        'username': this.username,
        'email': this.email,
        'phoneNumber': this.username,
        'profilePicture': this.profilePicture
      };
}
