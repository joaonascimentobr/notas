import 'package:flutter/material.dart';
import 'package:notas/widgets/meu_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const NotasHomePage(),
    );
  }
}

class NotasHomePage extends StatelessWidget {
  const NotasHomePage({super.key});

  static const List<Map<String, dynamic>> _notasMock = [
    {
      'texto': 'Comprar café e pão',
      'cor': Color(0xFFFFF59D),
      'tamanho': 120.0,
    },
    {
      'texto': 'Estudar Flutter 1h hoje',
      'cor': Color(0xFFB3E5FC),
      'tamanho': 140.0,
    },
    {
      'texto': 'Revisar tarefas da semana',
      'cor': Color(0xFFC8E6C9),
      'tamanho': 130.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas notas'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _notasMock.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final nota = _notasMock[index];
          return MeuCard(
            texto: nota['texto'] as String,
            cor: nota['cor'] as Color,
            tamanho: nota['tamanho'] as double,
          );
        },
      ),
    );
  }
}
