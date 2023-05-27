import 'package:flutter/material.dart';
import 'package:sps_app/screens/authentication/login.dart';
import 'package:sps_app/screens/authentication/login_manager.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:sps_app/screens/authentication/new_password.dart';
import 'package:sps_app/screens/settings/change_password.dart';
import 'package:sps_app/screens/settings/security.dart';
import 'package:sps_app/screens/settings/settings.dart';

class CPSecurityQuestionsPage extends StatefulWidget {
  const CPSecurityQuestionsPage({super.key});

  @override
  State<CPSecurityQuestionsPage> createState() => _CPSecurityQuestionsPage();
}

class _CPSecurityQuestionsPage extends State<CPSecurityQuestionsPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        // to center the widgets/UI elements on the page
        body: Center(
            // to structure the UI elements in a single column
            child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(const Size(350, 80)),
                child: Text(
                  'In order to change your password, please answer the following security questions.',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
            ),
            // padding for questions text box for better UI layout
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size(350, 20)),
                  child: Text(
                    _question1['question'],
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 16),
                  )),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                // constrained box to encapsulate user input text box
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size(350, 50)),
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size(350, 50)),
                  child: Text(
                    _question2['question'],
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 16),
                  )),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                // constrained box to encapsulate user input text box
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size(350, 50)),
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
                    constraints: BoxConstraints.tight(const Size(350, 50)),
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
                    Navigator.pop(context);
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
                              builder: (context) =>
                                  const ChangePasswordPage()));
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
  }

  static Digest _hashData(String data) {
    var bytes = utf8.encode(data);
    return sha256.convert(bytes);
  }
}
