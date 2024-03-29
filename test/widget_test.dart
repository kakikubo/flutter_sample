// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_sample/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Navigation smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    var nextButton = find.text('Next Page');
    var backButton = find.text('Go back');

    expect(nextButton, findsOneWidget);
    expect(backButton, findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(nextButton);
    await tester.pumpAndSettle();

    // Verify that our counter has incremented.
    expect(nextButton, findsNothing);
    expect(backButton, findsOneWidget);

    await tester.tap(backButton);
    await tester.pumpAndSettle();

    expect(nextButton, findsOneWidget);
    expect(backButton, findsNothing);
  });
}
