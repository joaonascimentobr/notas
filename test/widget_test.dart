import 'package:flutter_test/flutter_test.dart';
import 'package:notas/main.dart';

void main() {
  testWidgets('Notas home smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Minhas notas'), findsOneWidget);
    expect(find.text('Comprar café e pão'), findsOneWidget);
  });
}
