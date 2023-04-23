import 'package:flutter/material.dart';
import 'package:sps_app/http_handler.dart';
import 'package:sps_app/screens/authentication/forgot_password.dart';
import 'package:sps_app/screens/authentication/login_manager.dart';
import 'package:sps_app/account_manager.dart';
import 'package:sps_app/screens/nav.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final myUsernameController = TextEditingController();
  final myPasswordController = TextEditingController();
  String _invalidMessage = "";

  void _isValidMessage(bool value) {
    setState(() {
      if (value == true) {
        _invalidMessage = "";
      } else {
        _invalidMessage = "Incorrect email or password";
      }
    });
  }

  void moveToApp(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NavBar()));
  }

  @override
  void initState() {
    HTTPManager.authSessionToken(
            AccountManager.getSessionToken(), AccountManager.getID())
        .then((_) => moveToApp(context))
        .catchError((_) =>
            {}); // This does nothing becasue nothing in this page should change if as ses token auth fails
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myUsernameController.dispose();
    myPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfffcfbfb),
        // to center the widgets/UI elements on the page
        body: Center(
            // to structure the UI elements in a single column
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // inserts the medical school logo
            Image.asset('lib/assets/images/health_science_logo.png',
                height: 200, scale: 0.5),
            const Text('SPS-App', style: TextStyle(fontSize: 18)),
            // padding for email text box for better UI layout
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                // constrained box to encapsulate user input text box
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size(300, 70)),
                  child: TextFormField(
                      // styles user input text box
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xff917248), width: 3)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xff917248), width: 3)),
                        labelText: 'Enter your email',
                        labelStyle: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      cursorColor: const Color(0xff917248),
                      // to retrieve the user input text from the TextFormField
                      controller: myUsernameController),
                )),
            // padding for password text box for better UI layout
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              // constrained box to encapsulate user input text box
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(const Size(300, 70)),
                child: TextFormField(
                  obscureText: true,
                  // styles user input text box
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff917248), width: 3)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff917248), width: 3)),
                    labelText: 'Enter your password',
                    labelStyle: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  cursorColor: const Color(0xff917248),
                  // to retrieve the user input text from the TextFormField
                  controller: myPasswordController,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                child: ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(300, 25)),
                    child: Text(_invalidMessage,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                        textAlign: TextAlign.center))),
            // creates forgot password object
            // login button to validate,login and transfer user to next page
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgotPasswordPage()),
                );
              },
              child: const Text('Forgot Password?'),
            ),
            ElevatedButton(
              onPressed: () {
                LoginManager.setUsername(myUsernameController.text);
                LoginManager.setPassword(myPasswordController.text);
                // to check if users credentials are correct
                // to control access into the app
                LoginManager.validateLogin()
                    .then((value) => {
                          if (!value)
                            {AccountManager.saveAccount(), moveToApp(context)}
                          else
                            {
                              // This is for a new account
                            }
                        })
                    .catchError((_) {
                  _isValidMessage(false);
                });
              },
              // styles login button
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff043673)),
              child: const Text('Login'),
            ),
          ],
        )));
  }
}
