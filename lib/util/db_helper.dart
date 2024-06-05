import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:icm_app_2/models/visita.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final _databaseName = "icm_campinas.db";
  static final _databaseVersion = 8;

  Map registros = Map<String, dynamic>();

  // Uso

  //final dbHelper = DatabaseHelper.instance;

  static final sqlCreate = [
    "CREATE TABLE area(id_area INTEGER, id_municipio INTEGER, codigo TEXT)",
    "CREATE TABLE censitario(id_censitario INTEGER, id_area INTEGER, codigo TEXT)",
    "CREATE TABLE quarteirao(id_quarteirao INTEGER, id_censitario INTEGER, numero TEXT, sub_numero TEXT)",
    "CREATE TABLE visita(id_visita INTEGER PRIMARY KEY, id_municipio INTEGER, id_area INTEGER, id_censitario INTEGER, id_quarteirao INTEGER, dt_cadastro TEXT, agente TEXT, " +
        "ordem INTEGER, endereco TEXT, numero TEXT, idTipo INTEGER, fachada INTEGER, casa INTEGER, quintal INTEGER, sombra_quintal INTEGER, pav_quintal INTEGER, telhado INTEGER, recipiente INTEGER, " +
        "latitude REAL, longitude REAL, foto TEXT, status INTEGER)",
  ];
  static final tabelas = {
    "area",
    "censitario",
    "quarteirao",
    "visita",
  };

  // torna esta classe singleton
  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();
  // tem somente uma referência ao banco de dados
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    // instancia o db na primeira vez que for acessado
    _database = await _initDatabase();
    return _database;
  }

  // abre o banco de dados e o cria se ele não existir
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onUpgrade: _onUpgrade,
      onCreate: _onCreate,
    );
  }

  Future _onUpgrade(Database db, int version, int newVersion) async {
    await _persiste(db);
    for (var e in tabelas) {
      await db.execute("DROP TABLE IF EXISTS $e");
    }
    await _onCreate(db, newVersion);
    _recupera(db);
  }

  // Código SQL para criar o banco de dados e as tabelas
  Future _onCreate(Database db, int version) async {
    //
    Batch batch = db.batch();
    try {
      sqlCreate.forEach((e) {
        batch.execute(e);
      });
      await batch.commit();
    } catch (e) {
      debugPrint('Erro criando tabela $e');
    }
  }

  Future<int> insert(Map<String, dynamic> row, String table) async {
    Database? db = await instance.database;
    return await db!.insert(table, row);
  }

  // Todas as linhas são retornadas como uma lista de mapas, onde cada mapa é
  // uma lista de valores-chave de colunas.
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  Future<Map<String, dynamic>> queryObj(String table, int id) async {
    Database? db = await instance.database;
    var resultset =
        await db!.query(table, where: 'id_visita = ?', whereArgs: [id]);
    return resultset[0];
  }

  Future<int?> queryRowCount(String table) async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(Map<String, dynamic> row, String table, int id) async {
    Database? db = await instance.database;
    String idField = 'id_$table';
    return await db!.update(table, row, where: '$idField = ?', whereArgs: [id]);
  }

  Future<int> delete(int id, String table) async {
    Database? db = await instance.database;
    String idField = 'id_$table';
    return await db!.delete(table, where: '$idField = ?', whereArgs: [id]);
  }

  Future<int> limpa(String table) async {
    Database? db = await instance.database;
    return await db!.delete(table);
  }

  Future<int> limpaVisita(int tipo) async {
    Database? db = await instance.database;
    if (tipo == 1) {
      return await db!.delete('visita');
    } else {
      return await db!.delete('visita', where: 'status = ?', whereArgs: [1]);
    }
  }

  Future<void> _persiste(Database db) async {
    //fornecer valor padrão para o campo alterado
    final persTabela = ["area", "censitario", "quarteirao", "visita"];
    for (var element in persTabela) {
      var lista = [];
      await db.query(element).then((value) {
        for (var row in value) {
          //value.forEach((row) {
          lista.add(row);
        } //);
        registros[element] = lista;
      });
    }
  }

  Future<List<LstMaster>> consultaVisitasMaster() async {
    Database? db = await instance.database;
    var sql =
        'SELECT v.dt_cadastro, a.codigo as area, q.id_quarteirao as id_quadra, q.numero as quadra, v.status FROM visita v join area a on v.id_area=a.id_area' +
            ' join quarteirao q on v.id_quarteirao=q.id_quarteirao GROUP BY v.dt_cadastro, a.codigo, q.id_quarteirao, q.numero, v.status';
    List<Map<String, dynamic>> resultSet = await db!.rawQuery(sql);

    List<LstMaster> list = new List.generate(resultSet.length, (index) {
      return LstMaster.fromJson(resultSet[index]);
    });

    return list;
  }

  Future<List<LstDetail>> consultaVisitasDetail(int id) async {
    Database? db = await instance.database;

    List<Map<String, dynamic>> resultSet =
        await db!.query('visita', where: 'id_quarteirao=?', whereArgs: [id]);

    List<LstDetail> list = new List.generate(resultSet.length, (index) {
      return LstDetail.fromJson(resultSet[index]);
    });

    return list;
  }

  _recupera(Database db) async {
    //print(registros);
    final persTabela = [
      "area",
      "censitario",
      "quarteirao",
      "visita",
    ];
    for (var element in persTabela) {
      var tab = registros[element];
      for (var reg in tab) {
        db.insert(element, reg);
      }
    }
  }

  Future<List<Map>> qryCombo(String tabela, filtro) async {
    Database? db = await instance.database;
    String sql;
    if (tabela == 'quarteirao') {
      sql = 'SELECT id_$tabela as id, numero as nome FROM $tabela';
    } else if (tabela == 'area' || tabela == 'censitario') {
      sql = 'SELECT id_$tabela as id, codigo as nome FROM $tabela';
    } else {
      sql = 'SELECT id_$tabela as id, nome FROM $tabela';
    }
    sql += filtro == '' ? ' ORDER BY id' : ' WHERE $filtro ORDER BY id';
    //print(sql);
    return await db!.rawQuery(sql);
  }

  Future<int> qryCountEnvio() async {
    Database? db = await instance.database;
    String sql = 'SELECT count(*) as qt FROM visita WHERE status=0';
    var qt = 0;
    var resultSet = await db!.rawQuery(sql);

    var dbItem = resultSet.first;
    // Access its id
    qt = int.parse(dbItem['qt'].toString());

    return qt;
  }

  Future<List<Map>> qryEnvio() async {
    Database? db = await instance.database;
    var resultSet =
        await db!.query('visita', where: 'status=?', whereArgs: [0]);

    return resultSet;
  }

  Future<int> updateStatus(linha) async {
    Database? db = await instance.database;

    var result = await db!.update('visita', {'status': linha['status']},
        where: 'id_visita = ?', whereArgs: [linha['id']]);

    return result;
  }
}
