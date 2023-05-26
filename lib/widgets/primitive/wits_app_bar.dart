import 'package:flutter/material.dart';

class WitsAppBar extends AppBar {
  WitsAppBar({super.key, required BuildContext context})
      : super(
            automaticallyImplyLeading: false,
            leading: Image.asset('lib/assets/images/wits_logo_blue.png',
                fit: BoxFit.fitHeight),
            title: Text(
              'Wits University',
              style: TextStyle(
                  fontSize: 25, color: Theme.of(context).colorScheme.onPrimary),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_none,
                  size: 35,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                alignment: Alignment.topRight,
                padding: const EdgeInsets.fromLTRB(
                    16, 12, 25, 12), //padding of the notification icon
              )
            ]);
}
