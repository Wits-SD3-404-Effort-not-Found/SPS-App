import 'package:flutter/material.dart';

class SingleProtocolPage extends StatelessWidget {
  final String protocolContent;
  const SingleProtocolPage({super.key, required this.protocolContent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text(protocolContent,
                style: const TextStyle(fontSize: 30, color: Colors.cyan))));
  }
}
