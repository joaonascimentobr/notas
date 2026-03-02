import 'package:flutter/material.dart';

class Nota {
  final String texto;
  final Color cor;
  final double tamanho;

  const Nota({required this.texto, required this.cor, required this.tamanho});

  factory Nota.fromMap(Map<String, dynamic> map) {
    return Nota(
      texto: map['texto'] as String? ?? '',
      cor: _parseColor(map['cor']),
      tamanho: (map['tamanho'] as num?)?.toDouble() ?? 150,
    );
  }

  static Color _parseColor(dynamic value) {
    if (value is int) {
      return Color(value);
    }

    if (value is String) {
      final cleaned = value.replaceFirst('#', '');
      final argb = cleaned.length == 6 ? 'FF$cleaned' : cleaned;
      final parsed = int.tryParse(argb, radix: 16);
      if (parsed != null) {
        return Color(parsed);
      }
    }

    return Colors.amber;
  }
}
