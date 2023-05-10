import 'package:flutter/material.dart';
import 'package:sps_app/screens/authentication/login.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sps_app/account_manager.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('account');

  var accountBox = Hive.box('account');
  AccountManager.setSessionToken(
      accountBox.get('session_token', defaultValue: ""));
  AccountManager.setID(accountBox.get('account_id', defaultValue: 0));

  runApp(Phoenix(
      child: const MaterialApp(
    title: 'SPS-App',
    home: LoginPage(),
  )));
}
