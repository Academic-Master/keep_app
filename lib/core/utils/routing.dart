import 'package:flutter/material.dart';
import 'package:keep_app/features/auth/presentation/pages/login/login.dart';
import 'package:keep_app/features/medecine/presentation/pages/home/home.dart';

Route onRouting(RouteSettings route) {
  switch (route.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => Login());
    case '/login':
      return MaterialPageRoute(builder: (_) => Home());
  }
  return MaterialPageRoute(builder: (_) => Login());
}
