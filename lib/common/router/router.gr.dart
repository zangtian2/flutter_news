// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../pages/application/application.dart';
import '../../pages/sign_in/sign_in.dart';
import '../../pages/sign_up/sign_up.dart';
import '../../pages/welcome/welcome.dart';

class Routes {
  static const String welcomePage = '/';
  static const String signInPage = '/sign-in-page';
  static const String signUpPage = '/sign-up-page';
  static const String applicationPage = '/application-page';
  static const all = <String>{
    welcomePage,
    signInPage,
    signUpPage,
    applicationPage,
  };
}

class AppRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.welcomePage, page: WelcomePage),
    RouteDef(Routes.signInPage, page: SignInPage),
    RouteDef(Routes.signUpPage, page: SignUpPage),
    RouteDef(Routes.applicationPage, page: ApplicationPage),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    WelcomePage: (data) {
      final args = data.getArgs<WelcomePageArguments>(
        orElse: () => WelcomePageArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => WelcomePage(key: args.key),
        settings: data,
      );
    },
    SignInPage: (data) {
      final args = data.getArgs<SignInPageArguments>(
        orElse: () => SignInPageArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignInPage(key: args.key),
        settings: data,
      );
    },
    SignUpPage: (data) {
      final args = data.getArgs<SignUpPageArguments>(
        orElse: () => SignUpPageArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignUpPage(key: args.key),
        settings: data,
      );
    },
    ApplicationPage: (data) {
      final args = data.getArgs<ApplicationPageArguments>(
        orElse: () => ApplicationPageArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ApplicationPage(key: args.key),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// WelcomePage arguments holder class
class WelcomePageArguments {
  final Key key;
  WelcomePageArguments({this.key});
}

/// SignInPage arguments holder class
class SignInPageArguments {
  final Key key;
  SignInPageArguments({this.key});
}

/// SignUpPage arguments holder class
class SignUpPageArguments {
  final Key key;
  SignUpPageArguments({this.key});
}

/// ApplicationPage arguments holder class
class ApplicationPageArguments {
  final Key key;
  ApplicationPageArguments({this.key});
}
