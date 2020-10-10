import 'package:flutter/material.dart';
import 'package:news/global.dart';
import 'package:news/pages/welcome/welcome.dart';
import 'package:news/routes.dart';

void main() => Global.init().then((e) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: WelcomePage(),
      routes: staticRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
