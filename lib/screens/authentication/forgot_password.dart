import 'package:flutter/material.dart';
import 'package:sps_app/screens/authentication/login.dart';
import 'package:sps_app/screens/authentication/login_manager.dart';
import 'package:sps_app/screens/authentication/fp_security_questions.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  String _invalidMessage = "";

  void _isValidMessage(bool value) {
    setState(() {
      if (value == true) {
        _invalidMessage = "";
      } else {
        _invalidMessage = "Please enter a valid email address";
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    super.dispose();
  }

// coverage:ignore-start
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        // to center the widgets/UI elements on the page
        body: Center(
            // to structure the UI elements in a single column
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(const Size(300, 80)),
                child: Text(
                  'Enter your account email.',
                  style: TextStyle(
                      fontSize: 22,
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
            ),
            // padding for email text box for better UI layout
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                // constrained box to encapsulate user input text box
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size(300, 80)),
                  child: TextFormField(
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                      // styles user input text box
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 3)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 3)),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      cursorColor: Theme.of(context).colorScheme.onBackground,
                      controller: emailController),
                )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                child: ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(300, 25)),
                    child: Text(_invalidMessage,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 16),
                        textAlign: TextAlign.center))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // cancel button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  // styles login button
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 20),
                // send button
                ElevatedButton(
                  onPressed: () {
                    LoginManager.setUsername(emailController.text);
                    LoginManager.validateEmail().then((value) => {
                          if (value == true)
                            {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FPSecurityQuestionsPage())),
                              _isValidMessage(value)
                            }
                          else
                            {_isValidMessage(value)}
                        });
                  },
                  // styles login button
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary),
                  child: const Text('Send'),
                ),
              ],
            ),
          ],
        )));
    // coverage:ignore-end
  }
}
