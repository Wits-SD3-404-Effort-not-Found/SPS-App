import 'package:flutter/material.dart';

class SingleNotePage extends StatelessWidget {
  final String noteContent;
  const SingleNotePage({super.key, required this.noteContent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text(noteContent, style: const TextStyle(fontSize: 30))));
  }
}
