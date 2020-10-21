import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:news/common/router/auth_grard.dart';
import 'package:news/common/router/router.gr.dart';
import 'package:news/global.dart';

void main() => Global.init().then((e) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      builder: ExtendedNavigator<AppRouter>(
        initialRoute: Routes.welcomePage,
        router: AppRouter(),
        guards: [AuthGuard()],
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
