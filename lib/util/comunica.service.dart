import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'db_helper.dart';

class ComunicaService {
  final dbHelper = DbHelper.instance;

  List<String> entidades = [
    "area",
    "censitario",
    "quarteirao",
  ];

  Future<List<dynamic>> postOldVisitas(
      BuildContext context, String dados) async {
    String _url = '';

    //print(dados);
    _url = 'http://200.144.1.23/icm_api/exporta.php';
    var values = {'dados': dados};
    final response = await http.post(Uri.parse(_url), body: values);
    var data = [];
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
    } else {
      throw Exception('Falha ao carregar cadastro');
    }
    return data;
  }

  Future<int> postVisitasOrig(
      BuildContext context, List<Map<dynamic, dynamic>> dados) async {
    final db = DbHelper.instance;
    String _url = '';
    //var rows = jsonDecode(dados);
    String file;
    _url = 'http://200.144.1.23/icm_api/exporta.php';
    var cont = 0;

    dados.forEach((row) async {
      file = row['foto'];

      String _row = jsonEncode(row);

      var request = http.MultipartRequest('POST', Uri.parse(_url));
      request.files.add(await http.MultipartFile.fromPath('file', file));
      request.fields['dados'] = _row;
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        var data = jsonDecode(responseString);
        db.updateStatus(data[0]).then((value) => cont += value);
        return Future.value(cont);
      } else {
        throw Exception('Falha ao carregar cadastro');
      }
    });
    return Future.value(cont);
  }

  Future<int> postVisitas(
      BuildContext context, Map<dynamic, dynamic> row) async {
    final db = DbHelper.instance;
    String _url = '';
    //var rows = jsonDecode(dados);
    String file;
    _url = 'http://200.144.1.23/icm_api/exporta.php';
    var cont = 0;

    file = row['foto'];

    String _row = jsonEncode(row);

    var request = http.MultipartRequest('POST', Uri.parse(_url));
    request.files.add(await http.MultipartFile.fromPath('file', file));
    request.fields['dados'] = _row;
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();
      var data = jsonDecode(responseString);
      db.updateStatus(data[0]).then((value) {
        cont += value;
        return Future.value(cont);
      });
    } else {
      throw Exception('Falha ao carregar cadastro');
    }
    return 0;
  }

  Future<String> getCadastro(BuildContext context, int mun) async {
    String _url = '';
    String resumo = 'Registros recebidos:\n';

    _url = 'http://200.144.1.23/icm_api/importa.php?tipo=cadastros&id=${mun}';

    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final dados = data['dados'];

      for (var linha in entidades) {
        final obj = dados[linha];
        if (obj == null) {
          continue;
        }
        await dbHelper.limpa(linha);
        Map<String, dynamic> row = new Map();
        int ct = 0;
        if (linha == 'area') {
          ct = 0;
          for (var campo in obj) {
            row['id_area'] = campo['id_area'];
            row['id_municipio'] = campo['id_municipio'];
            row['codigo'] = campo['codigo'].toString().trim();
            await dbHelper.insert(row, linha);
            ct++;
            //print('$ct areas');
          }
          resumo += ct > 0 ? 'Área: $ct registros\n' : '';
        } else if (linha == 'censitario') {
          ct = 0;
          for (var campo in obj) {
            row['id_censitario'] = campo['id_censitario'];
            row['id_area'] = campo['id_area'];
            row['codigo'] = campo['codigo'].toString().trim();
            await dbHelper.insert(row, linha);
            ct++;
          }
          resumo += ct > 0 ? 'Censitário: $ct registros\n' : '';
        } else if (linha == 'quarteirao') {
          ct = 0;
          for (var campo in obj) {
            row['id_quarteirao'] = campo['id_quarteirao'];
            row['id_censitario'] = campo['id_censitario'];
            row['numero'] = campo['numero_quarteirao'].toString().trim();
            row['sub_numero'] = campo['sub_numero'].toString().trim();
            await dbHelper.insert(row, linha);
            ct++;
          }
          resumo += ct > 0 ? 'Quarteirão: $ct registros\n' : '';
        }
      }
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: const Text('Cadastro recebido.'),
          backgroundColor: Colors.green[900],
        ),
      );
    } else {
      throw Exception('Falha ao carregar cadastro');
    }
    return resumo;
  }
}
