import 'package:flutter/material.dart';
import 'package:sps_app/account_manager.dart';
import 'package:sps_app/http_handler.dart';
import 'package:sps_app/screens/authentication/login_manager.dart';
import 'package:sps_app/screens/settings/account_settings.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:sps_app/screens/settings/security.dart';
import 'package:sps_app/screens/settings/appearance.dart';
import 'package:sps_app/widgets/primitive/wits_app_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // coverage:ignore-start
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WitsAppBar(context: context),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Text(
                'Settings',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
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
                                    builder: (context) => const AccountPage()),
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
                                    'Account',
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
                                        const AppearancePage()),
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
                                    'Appearance',
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
                                    builder: (context) => const SecurityPage()),
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
                                    'Security',
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
                              //we use login manager to set the username and password to an empty string to prevent previous login username and password remaining in memory
                              LoginManager.setUsername('');
                              LoginManager.setPassword('');
                              HTTPManager.removeSessionToken(
                                      AccountManager.getID())
                                  .then((value) => null);
                              AccountManager.clearAccount();
                              Phoenix.rebirth(context);
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                                ])))),
              ],
            ),
          )
        ]));
  } // coverage:ignore-end
}
