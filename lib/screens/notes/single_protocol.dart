import 'package:flutter/material.dart';

class SingleProtocolPage extends StatelessWidget {
  final String protocolHeading;
  final String protocolContent;
  const SingleProtocolPage({super.key, required this.protocolContent, required this.protocolHeading});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            children: <Widget>[
              Container(
                height: 55,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xff917248), width: 2)
                  )
                ),
                child: Text(
                    protocolHeading, style: const TextStyle(fontSize: 30),
                ),
              ),
             SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 8),
                  child: Text(
                      protocolContent, style: const TextStyle(fontSize: 20)
                  ),
                ),
              )
            ]
        )
    );
  }
}
