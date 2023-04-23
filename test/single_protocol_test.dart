import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sps_app/screens/notes/single_protocol.dart';

void main() {
  //test that the protocol has a heading and content which appears
  testWidgets('Protocol has text', (tester) async {
    Widget testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
            home: SingleProtocolPage(
                protocolContent: 'Hello World',
                protocolHeading: 'Testing Data')));

    await tester.pumpWidget(testWidget);

    final contentText = find.text('Hello World');
    final headingText = find.text('Testing Data');

    expect(contentText, findsOneWidget);
    expect(headingText, findsOneWidget);
  });
}