import 'package:flutter/material.dart';

class MeuCard extends StatelessWidget {
  final String texto;
  final Color cor;
  final double tamanho;

  const MeuCard({
    super.key,
    required this.texto,
    this.cor = Colors.amber,
    this.tamanho = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: tamanho,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: cor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        texto,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
