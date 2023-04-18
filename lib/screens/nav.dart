import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sps_app/screens/calendar/calendar.dart';
import 'package:sps_app/screens/messaging/messaging.dart';
import 'package:sps_app/screens/notes/individual.dart';
import 'package:sps_app/screens/notes/notes.dart';
import 'package:sps_app/screens/settings/settings.dart';
import 'package:unicons/unicons.dart';

//BuildContext testContext;

class App extends StatelessWidget {
  const App({required final Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "Persistent Nav Bar",
        home: const NavBar(),
        initialRoute: "/",
        routes: {
          "/calendar": (final context) => const CalendarPage(),
          //"/notes": (final context) => NotesPage(),
          "/messaging": (final context) => MessagingPage(),
          "/settings": (final context) => SettingsPage()
        },
      );
}

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
  //gonna use style 6
  int _selectedIndex = 0;
  late PersistentTabController _controller;

  // list of all the screens that the navbar accesses
  List<Widget> _buildScreens() => [
        CalendarPage(),
        NotesPage(),
        MessagingPage(),
        SettingsPage(),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.calendar_month_rounded, size: 35),
          title: ("Calendar"),
          activeColorPrimary: Color(0xFF917248),
          inactiveColorPrimary: Color(0xFFFFFFFF),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(UniconsLine.file_edit_alt, size: 35),
          title: "Notes",
          activeColorPrimary: Color(0xFF917248),
          inactiveColorPrimary: Color(0xFFFFFFFF),
          /*routeAndNavigatorSettings: RouteAndNavigatorSettings(
                initialRoute: "/notes",
                routes: {"/notes": (context) => NotesPage()})*/
        ),
        PersistentBottomNavBarItem(
            icon: Icon(UniconsLine.comments, size: 35),
            title: "Messages",
            activeColorPrimary: Color(0xFF917248),
            inactiveColorPrimary: Color(0xFFFFFFFF),
            routeAndNavigatorSettings: RouteAndNavigatorSettings(
                initialRoute: "/",
                routes: {
                  "/Messaging": (final context) => const MessagingPage()
                })),
        PersistentBottomNavBarItem(
            icon: Icon(UniconsLine.setting, size: 35),
            title: "Settings",
            activeColorPrimary: Color(0xFF917248),
            inactiveColorPrimary: Color(0xFFFFFFFF),
            routeAndNavigatorSettings: RouteAndNavigatorSettings(
                initialRoute: "/",
                routes: {"/settings": (final context) => const SettingsPage()}))
      ];
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //this is the top bar of the App and contains a notification button which will open up a new page in the future
          /*leading: Image.asset(
            'lib/assets/wits_logo_blue.png',
            fit: BoxFit.fitHeight,
          ),*/
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
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        resizeToAvoidBottomInset: true,
        navBarHeight: 65,
        // MediaQuery.of(context).viewInsets.bottom > 0
        //     ? 0.0
        //     : kBottomNavigationBarHeight,
        // bottomScreenMargin: 0,
        //selectedTabScreenContext: (final context) => {testContext = context!},
        backgroundColor: Color(0xFF043673),
        decoration: const NavBarDecoration(
          colorBehindNavBar: Color(0xFF043673),
        )
        /*itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        )*/
        ,
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
        ),
        navBarStyle: NavBarStyle.style6,
      ),
    );
  }
}
