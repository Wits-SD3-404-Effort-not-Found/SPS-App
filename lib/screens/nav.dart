import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sps_app/screens/calendar/calendar.dart';
import 'package:sps_app/screens/messaging/messaging.dart';
import 'package:sps_app/screens/notes/notes.dart';
import 'package:sps_app/screens/settings/settings.dart';
import 'package:sps_app/widgets/primitive/wits_app_bar.dart';
import 'package:unicons/unicons.dart';

//BuildContext testContext;

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
  //gonna use style 6

  late PersistentTabController _controller;

  // list of all the screens that the navbar accesses
  List<Widget> _buildScreens() => [
        const CalendarPage(),
        const NotesPage(),
        const MessagingPage(),
        const SettingsPage(),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.calendar_month_rounded, size: 35),
          title: ("Calendar"),
          activeColorPrimary: Theme.of(context).colorScheme.secondary,
          inactiveColorPrimary: Theme.of(context).colorScheme.onPrimary,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(UniconsLine.file_edit_alt, size: 35),
          title: "Notes",
          activeColorPrimary: Theme.of(context).colorScheme.secondary,
          inactiveColorPrimary: Theme.of(context).colorScheme.onPrimary,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(UniconsLine.comments, size: 35),
          title: "Messages",
          activeColorPrimary: Theme.of(context).colorScheme.secondary,
          inactiveColorPrimary: Theme.of(context).colorScheme.onPrimary,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(UniconsLine.setting, size: 35),
          title: "Settings",
          activeColorPrimary: Theme.of(context).colorScheme.secondary,
          inactiveColorPrimary: Theme.of(context).colorScheme.onPrimary,
        )
      ];
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WitsAppBar(context: context),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        resizeToAvoidBottomInset: true,
        navBarHeight: 65,
        backgroundColor: Theme.of(context).colorScheme.primary,
        decoration: NavBarDecoration(
            colorBehindNavBar: Theme.of(context).colorScheme.primary),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
        ),
        navBarStyle: NavBarStyle.style6,
      ),
    );
  }
}
