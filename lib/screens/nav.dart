import 'package:flutter/material.dart';
import 'package:sps_app/screens/calendar/calendar.dart';
import 'package:sps_app/screens/messaging/messaging.dart';
import 'package:sps_app/screens/notes/notes.dart';
import 'package:sps_app/screens/settings/settings.dart';
import 'package:unicons/unicons.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
  int _selectedIndex = 0;

  // list of all the screens that the navbar accesses
  final screens = [
    const CalendarPage(),
    const NotesPage(),
    const MessagingPage(),
    const SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //this is the top bar of the App and contains a notification button which will open up a new page in the future
          leading: Image.asset(
            'lib/assets/wits_logo_blue.png',
            fit: BoxFit.fitHeight,
          ),
          title: const Text(
            'Wits University',
            style: TextStyle(fontSize: 25),
          ),
          backgroundColor: const Color(0xFF043673),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none,
                size: 35,
              ),
              alignment: Alignment.topRight,
              padding: const EdgeInsets.fromLTRB(
                  16, 12, 25, 12), //padding of the notification icon
            )
          ]),
      // Center: the page will change dependent on the selected index of the nav bar
      body: Center(
        child: screens[_selectedIndex],
      ),
      // This is the UI for the bottom navigator which contains the icons that represent each page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,

        // this changes the pages depending on the selected index
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month_rounded,
              size: 35,
            ),
            label: 'Calendar',
            backgroundColor: Color(0xFF043673),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              UniconsLine.file_edit_alt,
              size: 35,
            ),
            label: 'Notes',
            backgroundColor: Color(0xFF043673),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              UniconsLine.comments,
              size: 35,
            ),
            label: 'Messages',
            backgroundColor: Color(0xFF043673),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              UniconsLine.setting,
              size: 35,
            ),
            label: 'Settings',
            backgroundColor: Color(0xFF043673),
          ),
        ],
        selectedItemColor: const Color(0xFF917248),
      ),
    );
  }
}