import 'package:flutter_test/flutter_test.dart';
import 'package:decoriyans/main.dart';

void main() {
  testWidgets('Decoriyans app boots', (WidgetTester tester) async {
    await tester.pumpWidget(const DecoriyansApp());
    await tester.pump();
    expect(find.byType(DecoriyansApp), findsOneWidget);
  });
}
