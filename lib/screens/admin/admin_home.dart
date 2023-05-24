import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Image.asset('lib/assets/images/wits_logo_blue.png',
            fit: BoxFit.fitHeight),
        title: Text(
          'Wits University',
          style: TextStyle(
              fontSize: 25, color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Text(
                  "Supervisor",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground),
                ))),
        Center(
          child: Column(
            children: [
              ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size(360, 60)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                    child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            side: BorderSide(
                                width: 3,
                                color: Theme.of(context).colorScheme.primary)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Student Notes',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 22),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ])),
                  )),
              ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size(360, 60)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                    child: TextButton(
                        onPressed: () {
                          Phoenix.rebirth(context);
                        },
                        style: TextButton.styleFrom(
                            side: BorderSide(
                                width: 3,
                                color: Theme.of(context).colorScheme.primary)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Logout',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 22),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ])),
                  ))
            ],
          ),
        )
      ]),
    );
  }
}
