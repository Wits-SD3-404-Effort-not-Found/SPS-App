import 'package:flutter/material.dart';
import 'package:sps_app/screens/authentication/login.dart';
import 'package:sps_app/screens/authentication/login_manager.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:sps_app/screens/authentication/new_password.dart';

class FPSecurityQuestionsPage extends StatefulWidget {
  const FPSecurityQuestionsPage({super.key});

  @override
  State<FPSecurityQuestionsPage> createState() =>
      _FPSecurityQuestionsPageState();
}

class _FPSecurityQuestionsPageState extends State<FPSecurityQuestionsPage> {
  final q1Controller = TextEditingController();
  final q2Controller = TextEditingController();
  final Map<String, dynamic> _question1 = LoginManager.getQuestion(0);
  final Map<String, dynamic> _question2 = LoginManager.getQuestion(1);
  String _invalidMessage = "";

  void _isValidMessage(bool value) {
    setState(() {
      if (value == true) {
        _invalidMessage = "";
      } else {
        _invalidMessage = "Incorrect answers";
      }
    });
  }

  @override
  void dispose() {
    q1Controller.dispose();
    q2Controller.dispose();
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
                constraints: BoxConstraints.tight(const Size(300, 60)),
                child: Text(
                  'Answer the following security questions.',
                  style: TextStyle(
                      fontSize: 22,
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
            ),
            // padding for questions text box for better UI layout
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size(300, 20)),
                  child: Text(
                    _question1['question'],
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 16),
                  )),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                // constrained box to encapsulate user input text box
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size(300, 80)),
                  child: TextFormField(
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
                        labelText: 'Answer',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      controller: q1Controller),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size(300, 20)),
                  child: Text(
                    _question2['question'],
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 16),
                  )),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                // constrained box to encapsulate user input text box
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size(300, 80)),
                  child: TextFormField(
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
                        labelText: 'Answer',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      controller: q2Controller),
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
                    LoginManager.clearQuestions();
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
                // confirm button
                ElevatedButton(
                  onPressed: () {
                    //authenticate answers
                    var areCorrectAnswers =
                        _question1['answer'].toString().toLowerCase() !=
                                _hashData(q1Controller.text).toString() ||
                            _question2['answer'].toString().toLowerCase() !=
                                _hashData(q2Controller.text).toString();
                    _isValidMessage(areCorrectAnswers);

                    if (areCorrectAnswers) {
                      LoginManager.setAnswers(
                          q1Controller.text, q2Controller.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewPasswordPage()));
                    }
                  },
                  // styles login button
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary),
                  child: const Text('Confirm'),
                ),
              ],
            ),
          ],
        )));
    // coverage:ignore-end
  }

  static Digest _hashData(String data) {
    var bytes = utf8.encode(data);
    return sha256.convert(bytes);
  }
}
