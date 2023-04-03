import 'package:flutter/material.dart';
import 'package:sps_app/screens/authentication/login.dart';

void main() {
  runApp(const MaterialApp(
    title: 'SPS-App',
    home: LoginPage(),
  ));
}

// not used currently on login branch can be removed/edited once light and dark mode is sorted out
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark());
  }
}
