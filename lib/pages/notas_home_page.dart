import 'package:flutter/material.dart';
import 'package:notas/models/nota.dart';
import 'package:notas/services/notas_service.dart';
import 'package:notas/widgets/meu_card.dart';

class NotasHomePage extends StatefulWidget {
  final NotasService? service;

  const NotasHomePage({super.key, this.service});

  @override
  State<NotasHomePage> createState() => _NotasHomePageState();
}

class _NotasHomePageState extends State<NotasHomePage> {
  late final Future<List<Nota>> _notasFuture;

  @override
  void initState() {
    super.initState();
    final service = widget.service ?? NotasService();
    _notasFuture = service.fetchNotas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas notas')),
      body: FutureBuilder<List<Nota>>(
        future: _notasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar notas'));
          }

          final notas = snapshot.data ?? const <Nota>[];
          if (notas.isEmpty) {
            return const Center(child: Text('Nenhuma nota encontrada'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: notas.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final nota = notas[index];
              return MeuCard(
                texto: nota.texto,
                cor: nota.cor,
                tamanho: nota.tamanho,
              );
            },
          );
        },
      ),
    );
  }
}
