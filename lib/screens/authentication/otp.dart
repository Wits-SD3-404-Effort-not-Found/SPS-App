import 'package:flutter/material.dart';
import 'package:sps_app/screens/authentication/login.dart';
import 'package:sps_app/screens/authentication/login_manager.dart';
import 'package:sps_app/screens/authentication/new_password.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final otpController = TextEditingController();
  String _invalidMessage = "";

  void _isValidMessage(bool value) {
    setState(() {
      if (value == true) {
        _invalidMessage = "";
      } else {
        _invalidMessage = "Incorrect OTP";
      }
    });
  }

  @override
  void dispose() {
    otpController.dispose();
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(const Size(300, 80)),
                child: const Text(
                  'Enter the OTP that was sent to your email.',
                  style: TextStyle(fontSize: 22),
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
                      // styles user input text box
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xff917248), width: 3)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xff917248), width: 3)),
                        labelText: 'OTP',
                        labelStyle: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      cursorColor: const Color(0xff917248),
                      controller: otpController),
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
                      backgroundColor: const Color(0xff043673)),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 20),
                // confirm button
                ElevatedButton(
                  onPressed: () {
                    LoginManager.setOTP(otpController.text);
                    LoginManager.validateOTP().then((value) => {
                          if (value == true)
                            {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const NewPasswordPage()),
                              ),
                              _isValidMessage(value)
                            }
                          else
                            {_isValidMessage(value)}
                        });
                  },
                  // styles login button
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff043673)),
                  child: const Text('Confirm'),
                ),
              ],
            ),
          ],
        )));
  }
}
