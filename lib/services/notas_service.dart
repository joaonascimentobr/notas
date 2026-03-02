import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:notas/models/nota.dart';

enum NotasDataSource { localJson, api }

class NotasService {
  final NotasDataSource source;
  final String localJsonPath;
  final String apiUrl;
  final AssetBundle bundle;
  final http.Client? _client;

  NotasService({
    this.source = NotasDataSource.localJson,
    this.localJsonPath = 'assets/data/notas.json',
    this.apiUrl = '',
    AssetBundle? bundle,
    http.Client? client,
  }) : bundle = bundle ?? rootBundle,
       _client = client;

  Future<List<Nota>> fetchNotas() async {
    switch (source) {
      case NotasDataSource.localJson:
        return _fetchFromLocalJson();
      case NotasDataSource.api:
        return _fetchFromApi();
    }
  }

  Future<List<Nota>> _fetchFromLocalJson() async {
    final jsonString = await bundle.loadString(localJsonPath);
    return _parseNotas(jsonString);
  }

  Future<List<Nota>> _fetchFromApi() async {
    if (apiUrl.isEmpty) {
      throw Exception('apiUrl nao configurada para NotasDataSource.api');
    }

    final client = _client ?? http.Client();
    try {
      final response = await client.get(Uri.parse(apiUrl));
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw Exception(
          'Falha ao carregar notas da API: ${response.statusCode}',
        );
      }

      return _parseNotas(response.body);
    } finally {
      if (_client == null) {
        client.close();
      }
    }
  }

  List<Nota> _parseNotas(String jsonString) {
    final decoded = jsonDecode(jsonString);
    if (decoded is! List) {
      throw Exception('Formato invalido: esperado um array de notas');
    }

    return decoded
        .whereType<Map<String, dynamic>>()
        .map(Nota.fromMap)
        .toList(growable: false);
  }
}
