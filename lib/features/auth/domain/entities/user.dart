import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'entities_exception/user_exception.dart';

part 'user.g.dart';

/// User definition
@HiveType(typeId: 0)
class User extends Equatable {
  @HiveField(0)
  late final String username;

  @HiveField(2)
  late final String email;

  User({required String username, required String email}) {
    if (username.isEmpty) {
      throw UserException();
    } else {
      this.username = username;
      this.email = email;
    }
  }

// To json
  toJson() => {'username': this.username, 'email': this.email};

  @override
  List<String> get props => [this.username];
}
