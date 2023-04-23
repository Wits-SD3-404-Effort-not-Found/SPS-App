import 'package:flutter/material.dart';
import 'package:sps_app/account_manager.dart';
import 'package:sps_app/http_handler.dart';
import 'package:sps_app/screens/authentication/login.dart';
import 'package:sps_app/screens/authentication/login_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  //we use login manager to set the username and password to an empty string to prevent previous login username and password remaining in memory
                  LoginManager.setUsername('');
                  LoginManager.setPassword('');
                  HTTPManager.removeSessionToken(AccountManager.getID())
                      .then((value) => null);
                  AccountManager.clearAccount();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF043673),
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                child: const Text('Logout'))
          ],
        ),
      ),
    );
  }
}
