import 'package:flutter/material.dart';

class SingleProtocolPage extends StatelessWidget {
  final String protocolHeading;
  final String protocolContent;
  const SingleProtocolPage(
      {super.key,
      required this.protocolContent,
      required this.protocolHeading});
// coverage:ignore-start
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(children: <Widget>[
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
                              color: Theme.of(context).colorScheme.onBackground,
                            )))),
                Container(
                    height: 50,
                    width: 300,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      protocolHeading,
                      style: TextStyle(
                          fontSize: 30,
                          color: Theme.of(context).colorScheme.onBackground),
                      textAlign: TextAlign.left,
                    ))
              ])),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(protocolContent,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 20)),
            ),
          )
        ]));
  } // coverage:ignore-end
}
