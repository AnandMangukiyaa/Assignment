import 'dart:io';

import 'package:flutter_assignment/main.dart';
import 'package:flutter_assignment/pages/pages.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();


  static const String home = "./home";
  static const String login = "./login";
}

class RouteGenerator {
  RouteGenerator._();
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {

      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.login:
        return MaterialPageRoute(
            builder: (_) => const SignInPage());
      default:
        return null;
    }
  }
}
