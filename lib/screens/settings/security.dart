import 'package:flutter/material.dart';
import 'package:sps_app/screens/settings/cp_email.dart';
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
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(children: <Widget>[
          Center(
            child: Column(
              children: [
                Container(
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 2))),
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
                                  child: Icon(
                                    Icons.arrow_back_ios_rounded,
                                    size: 30,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  )))),
                      Container(
                          height: 50,
                          width: 300,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Settings",
                            style: TextStyle(
                                fontSize: 30,
                                color:
                                    Theme.of(context).colorScheme.onBackground),
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
                                side: BorderSide(
                                    width: 3,
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Change Password',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                        fontSize: 22),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
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
                                side: BorderSide(
                                    width: 3,
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Change Security Questions',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                        fontSize: 22),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                                ])))),
              ],
            ),
          )
        ]));
  }
}
