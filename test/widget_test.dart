// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:json_placeholder/main.dart';

void main() {
  testWidgets('JSONPlaceholder app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text('JSONPlaceholder API'), findsOneWidget);
    expect(find.text('Posts'), findsOneWidget);
    expect(find.text('Comments'), findsOneWidget);
    expect(find.text('Albums'), findsOneWidget);
    expect(find.text('Users'), findsOneWidget);
    expect(find.text('Photos'), findsOneWidget);
    expect(find.text('Todos'), findsOneWidget);
  });
}
