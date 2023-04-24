import 'package:flutter/material.dart';
import 'package:sps_app/screens/authentication/login.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sps_app/account_manager.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('account');

  var accountBox = Hive.box('account');
  AccountManager.setSessionToken(
      accountBox.get('session_token', defaultValue: ""));
  AccountManager.setID(accountBox.get('account_id', defaultValue: 0));

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
