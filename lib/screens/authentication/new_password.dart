import 'package:flutter/material.dart';

import 'login.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage>{
  @override
  Widget build (BuildContext context){
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
                      'Create new password',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                // padding for email text box for better UI layout
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    // constrained box to encapsulate user input text box
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tight(const Size(300, 80)),
                      child: TextFormField(
                        // styles user input text box
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff917248), width: 3)
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff917248), width: 3)
                          ),
                          labelText: 'New Password',
                          labelStyle: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        cursorColor: const Color(0xff917248),
                      ),
                    )
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    // constrained box to encapsulate user input text box
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tight(const Size(300, 80)),
                      child: TextFormField(
                        obscureText: true,
                        // styles user input text box
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff917248), width: 3)
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff917248), width: 3)
                          ),
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        cursorColor: const Color(0xff917248),
                      ),
                    )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
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
                    const SizedBox(width:20),
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
                      child: const Text('Confirm'),
                    ),
                  ],
                ),
              ],
            )
        )
    );
  }
}