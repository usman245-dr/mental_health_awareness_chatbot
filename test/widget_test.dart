import 'package:flutter_test/flutter_test.dart';

import 'package:mental_health_awareness_chatbot/main.dart';

void main() {
  testWidgets('App renders home page', (WidgetTester tester) async {
    await tester.pumpWidget(const MindfulChatApp());
    await tester.pumpAndSettle();

    expect(find.text('MindfulChat'), findsWidgets);
  });
}
