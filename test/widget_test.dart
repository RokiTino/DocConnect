import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:docconnect/main.dart';
import 'package:docconnect/care/care_app.dart';

void main() {
  testWidgets('Unconfigured builds show setup state instead of clinical data',
      (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.textContaining('clinic connection has not been configured'),
        findsOneWidget);
    expect(find.byType(CareHome), findsNothing);
  });
  testWidgets('Patient sign-in requests credentials without exposing records',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: CareSignIn()));
    expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
    expect(
        tester
            .widget<TextField>(find.widgetWithText(TextField, 'Password'))
            .obscureText,
        isTrue);
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.byType(CareHome), findsNothing);
  });
}
