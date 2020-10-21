import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/material.dart';
// import 'package:news/common/router/auth_grard.dart';
import 'package:news/pages/application/application.dart';
// import 'package:news/pages/details/details.dart';
// import 'package:news/pages/index/index.dart';
import 'package:news/pages/sign_in/sign_in.dart';
import 'package:news/pages/sign_up/sign_up.dart';
import 'package:news/pages/welcome/welcome.dart';

Widget zoomInTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  // you get an animation object and a widget
  // make your own transition
  return ScaleTransition(scale: animation, child: child);
}

@MaterialAutoRouter(
  generateNavigationHelperExtension: false,
  routes: <AutoRoute>[
    MaterialRoute(page: WelcomePage, initial: true),
    MaterialRoute(page: SignInPage),
    MaterialRoute(page: SignUpPage),
    MaterialRoute(page: ApplicationPage),
    // guards: [AuthGuard]
    // CustomRoute(page: ZoomInScreen, transitionsBuilder: zoomInTransition)
  ],
)
class $AppRouter {}
