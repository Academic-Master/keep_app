import 'package:keep_app/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required String username, required String email})
      : super(email: email, username: username);

  factory UserModel.factory(
          {required String username, required String email}) =>
      UserModel(
        username: username,
        email: email,
      );

  Map<String, String> toJson() => {
        'username': this.username,
        'email': this.email,
      };
}
