import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keep_app/features/auth/domain/entities/user.dart';

import 'root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<User>(UserAdapter());
  Box<User> _user = await Hive.openBox('user');
  runApp(KeepApp(
    userBox: _user,
  ));
}
