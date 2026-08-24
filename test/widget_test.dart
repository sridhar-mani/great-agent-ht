import 'package:flutter_test/flutter_test.dart';
import 'package:service_ops_a_i/main.dart';

void main() {
  testWidgets('ServiceOps AI App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('ServiceOps AI'), findsOneWidget);
  });
}
