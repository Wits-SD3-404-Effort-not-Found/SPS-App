import 'package:flutter/material.dart';
import 'package:sps_app/screens/settings/change_password.dart';
import 'package:sps_app/screens/settings/cp_email.dart';
import 'package:sps_app/screens/settings/cp_security_questions.dart';
import 'package:sps_app/screens/settings/security_questions.dart';

import '../../widgets/primitive/wits_app_bar.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({Key? key}) : super(key: key);

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WitsAppBar(
          context: context,
        ),
        backgroundColor: Colors.white,
        body: Column(children: <Widget>[
          Center(
            child: Column(
              children: [
                Container(
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.bottomLeft,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color(0xff917248), width: 2))),
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
                            "Settings",
                            style: TextStyle(fontSize: 30),
                            textAlign: TextAlign.left,
                          ))
                    ])),
                ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(360, 60)),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 6),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ChangePasswordEmailPage()),
                              );
                            },
                            style: TextButton.styleFrom(
                                side:
                                    const BorderSide(color: Color(0xff043673))),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Change Password',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 22),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ])))),
                ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(360, 60)),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 6),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ChangeSecurityQuestionPage()),
                              );
                            },
                            style: TextButton.styleFrom(
                                side:
                                    const BorderSide(color: Color(0xff043673))),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Change Security Questions',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 22),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ])))),
              ],
            ),
          )
        ]));
  }
}
