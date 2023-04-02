import 'package:flutter/material.dart';
import 'package:sps_app/screens/authentication/login_manager.dart';
import 'package:sps_app/screens/nav.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final myUsernameController = TextEditingController();
  final myPasswordController = TextEditingController();

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
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('lib/assets/images/health_science_logo.png',
                height: 200, scale: 0.5),
            const Text('SPS-App', style: TextStyle(fontSize: 18)),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size(300, 80)),
                  child: TextFormField(
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
                    controller: myUsernameController,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(const Size(300, 80)),
                child: TextFormField(
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
                  controller: myPasswordController,
                ),
              ),
            ),
            const ForgotPassword(),
            ElevatedButton(
              onPressed: () {
                LoginManager.setUsername(myUsernameController.text);
                LoginManager.setPassword(myPasswordController.text);
                LoginManager.validateLogin().then((value) => {
                      if (value == true)
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NavBar()),
                          )
                        }
                      else
                        {debugPrint("password incorrect")}
                    });
                //.catchError((error)=>debugPrint("password incorrect"));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff043673)),
              child: const Text('Login'),
            ),
          ],
        )));
  }
}

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            title: const Text('Forgot Password'),
            content: const Text("Enter your email"),
            actions: <Widget>[
              TextFormField(
                decoration: const InputDecoration(hintText: 'Email'),
              ),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Send'))
            ]),
      ),
      child: const Text('Forgot Password?'),
    );
  }
}
