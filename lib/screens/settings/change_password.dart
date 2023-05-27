import 'package:flutter/material.dart';
import 'package:sps_app/screens/authentication/login_manager.dart';
import 'package:sps_app/screens/settings/settings.dart';
import 'package:sps_app/widgets/primitive/wits_app_bar.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String _invalidMessage = "";

  void _isValidMessage(bool value) {
    setState(() {
      if (value == true) {
        _invalidMessage = "";
      } else {
        _invalidMessage = "Passwords do not match";
      }
    });
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WitsAppBar(
          context: context,
        ),
        backgroundColor: const Color(0xfffcfbfb),
        // to center the widgets/UI elements on the page
        body: Column(
          // to structure the UI elements in a single column
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.bottomLeft,
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xff917248), width: 2))),
                child: Row(children: [
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back_ios_rounded,
                                size: 30,
                                color: Colors.black,
                              )))),
                  Container(
                      height: 50,
                      width: 300,
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Change Password",
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.left,
                      ))
                ])),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                // constrained box to encapsulate user input text box
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size(300, 70)),
                  child: TextFormField(
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                      // styles user input text box
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  width: 3)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  width: 3)),
                          labelText: 'Enter New Password',
                          labelStyle: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.onBackground)),
                      cursorColor: Theme.of(context).colorScheme.primary,
                      // to retrieve the user input text from the TextFormField
                      controller: newPasswordController),
                )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                // constrained box to encapsulate user input text box
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size(300, 70)),
                  child: TextFormField(
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                      // styles user input text box
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  width: 3)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  width: 3)),
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.onBackground)),
                      cursorColor: Theme.of(context).colorScheme.primary,
                      // to retrieve the user input text from the TextFormField
                      controller: confirmPasswordController),
                )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                child: ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(300, 25)),
                    child: Text(_invalidMessage,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                        textAlign: TextAlign.center))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //cancel button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsPage()),
                    );
                  },
                  // styles login button
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff043673)),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 20),
                //confirm button
                ElevatedButton(
                  onPressed: () {
                    if (newPasswordController.text ==
                        confirmPasswordController.text) {
                      // set new pass word function
                      LoginManager.changePassword(newPasswordController.text)
                          .then((value) => {
                                if (value == true)
                                  {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SettingsPage()),
                                    ),
                                    _isValidMessage(value)
                                  }
                                else
                                  {debugPrint("reset password failed")}
                              });
                    } else {
                      _isValidMessage(false);
                    }
                  },
                  // styles login button
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff043673)),
                  child: const Text('Confirm'),
                ),
              ],
            ),
          ],
        ));
  }
}
