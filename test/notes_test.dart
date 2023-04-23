import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sps_app/screens/notes/notes.dart';

void main() {
  //testing that the text 'Notes' appears
  testWidgets('Testing Notes has text', (tester) async {
    Widget testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: NotesPage()));

    await tester.pumpWidget(testWidget);

    final textNotes = find.text('Notes');

    expect(textNotes, findsOneWidget);
  });

  //testing that the 'Protocols' button appears
  testWidgets('Testing Protocols button appears', (tester) async {
    Widget testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: NotesPage()));

    await tester.pumpWidget(testWidget);

    final buttonProtocolsText = find.widgetWithText(TextButton, 'Protocols');

    expect(buttonProtocolsText, findsOneWidget);
  });

  //testing that the 'Personal Notes' button appears
  testWidgets('Testing Personal Notes button appears', (tester) async {
    Widget testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: NotesPage()));

    await tester.pumpWidget(testWidget);

    final buttonPersonalNotesText = find.widgetWithText(TextButton, 'Personal Notes');

    expect(buttonPersonalNotesText, findsOneWidget);
  });

  //testing that the 'Logbook' button appears
  testWidgets('Testing Logbook button appear', (tester) async {
    Widget testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: NotesPage()));

    await tester.pumpWidget(testWidget);

    final buttonLogbookText = find.widgetWithText(TextButton, 'Logbook');

    expect(buttonLogbookText, findsOneWidget);
  });

}