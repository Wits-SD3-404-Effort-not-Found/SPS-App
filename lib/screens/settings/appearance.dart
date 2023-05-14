import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sps_app/misc/theme_provider.dart';

class AppearancePage extends StatelessWidget {
  const AppearancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
        body: Column(
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
                          child: Icon(Icons.arrow_back_ios_rounded,
                              size: 30,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground)))),
              Container(
                  height: 50,
                  width: 300,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Appearance Settings",
                    style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).colorScheme.onBackground),
                    textAlign: TextAlign.left,
                  ))
            ])),
        Expanded(
            child: Center(
          child: ElevatedButton(
              onPressed: () {
                if (themeNotifier.themeMode == ThemeMode.light) {
                  themeNotifier.setThemeMode(ThemeMode.dark);
                } else if (themeNotifier.themeMode == ThemeMode.dark) {
                  themeNotifier.setThemeMode(ThemeMode.light);
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary),
              child: const Text('Change Theme')),
        ))
      ],
    ));
  }
}
