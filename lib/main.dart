import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sps_app/misc/theme_provider.dart';
import 'package:sps_app/screens/authentication/login.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sps_app/account_manager.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('account');
  await Hive.openBox('theme');

  AccountManager.loadAccount();

  runApp(Phoenix(
      child: ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(), child: const SPSApp())));
}

class SPSApp extends StatelessWidget {
  const SPSApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      title: 'SPS-App',
      home: const LoginPage(),
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: themeNotifier.themeMode,
    );
  }
}

ThemeData lightTheme() {
  return ThemeData(
    colorScheme: lightColours(),
    textTheme: GoogleFonts.poppinsTextTheme(),
    scaffoldBackgroundColor: lightColours().background,
  );
}

ThemeData darkTheme() {
  return ThemeData(
      colorScheme: darkColours(),
      textTheme: GoogleFonts.poppinsTextTheme(),
      scaffoldBackgroundColor: darkColours().background);
}

ColorScheme lightColours() {
  const primaryColor = Color(0xff043673);
  const onPrimaryColor = Color(0xffffffff);
  const secondaryColor = Color(0xff917248);
  const onSecondaryColor = Color(0xffffffff);
  const tertiaryColor = Color(0xff2fac66);
  const onTertiaryColor = Color(0xffffffff);
  const errorColor = Color(0xffff0436);
  const onErrorColor = Color(0xffffffff);
  const backgroundColor = Color(0xfffcfbfb);
  const onBackgroundColor = Color(0xff000000);
  const surfaceColor = Color(0xffffffff);
  const onSurfaceColor = Color(0xff000000);

  return const ColorScheme(
    brightness: Brightness.dark,
    primary: primaryColor,
    onPrimary: onPrimaryColor,
    secondary: secondaryColor,
    onSecondary: onSecondaryColor,
    tertiary: tertiaryColor,
    onTertiary: onTertiaryColor,
    error: errorColor,
    onError: onErrorColor,
    background: backgroundColor,
    onBackground: onBackgroundColor,
    surface: surfaceColor,
    onSurface: onSurfaceColor,
  );
}

ColorScheme darkColours() {
  const primaryColor = Color(0xff043673);
  const onPrimaryColor = Color(0xffffffff);
  const secondaryColor = Color(0xff917248);
  const onSecondaryColor = Color(0xffffffff);
  const tertiaryColor = Color(0xff2fac66);
  const onTertiaryColor = Color(0xffffffff);
  const errorColor = Color(0xffff0436);
  const onErrorColor = Color(0xffffffff);
  const backgroundColor = Color(0xff18181c);
  const onBackgroundColor = Color(0xffffffff);
  const surfaceColor = Color(0xff606070);
  const onSurfaceColor = Color(0xffffffff);

  return const ColorScheme(
    brightness: Brightness.dark,
    primary: primaryColor,
    onPrimary: onPrimaryColor,
    secondary: secondaryColor,
    onSecondary: onSecondaryColor,
    tertiary: tertiaryColor,
    onTertiary: onTertiaryColor,
    error: errorColor,
    onError: onErrorColor,
    background: backgroundColor,
    onBackground: onBackgroundColor,
    surface: surfaceColor,
    onSurface: onSurfaceColor,
  );
}
