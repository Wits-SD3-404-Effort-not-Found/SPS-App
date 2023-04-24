import 'package:flutter/material.dart';

class SingleProtocolPage extends StatelessWidget {
  final String protocolHeading;
  final String protocolContent;
  const SingleProtocolPage(
      {super.key,
      required this.protocolContent,
      required this.protocolHeading});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      Container(
          height: 50,
          width: double.infinity,
          alignment: Alignment.bottomLeft,
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Color(0xff917248), width: 2))),
          child: Row(children: [
            Align(
                alignment: Alignment.center,
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                child: Text(
                  protocolHeading,
                  style: const TextStyle(fontSize: 30),
                  textAlign: TextAlign.left,
                ))
          ])),
      SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(protocolContent, style: const TextStyle(fontSize: 20)),
        ),
      )
    ]));
  }
}
