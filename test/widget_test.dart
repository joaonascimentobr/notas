import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notas/models/nota.dart';
import 'package:notas/pages/notas_home_page.dart';
import 'package:notas/services/notas_service.dart';

class _FakeNotasService extends NotasService {
  _FakeNotasService();

  @override
  Future<List<Nota>> fetchNotas() async {
    return const [
      Nota(texto: 'Comprar cafe e pao', cor: Color(0xFFFFF59D), tamanho: 120),
    ];
  }
}

void main() {
  testWidgets('Notas home smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: NotasHomePage(service: _FakeNotasService())),
    );
    await tester.pumpAndSettle();

    expect(find.text('Minhas notas'), findsOneWidget);
    expect(find.text('Comprar cafe e pao'), findsOneWidget);
  });
}
