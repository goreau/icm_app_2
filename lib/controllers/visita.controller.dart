import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:icm_app_2/controllers/camera.controller.dart';
import 'package:icm_app_2/models/visita.dart';
import 'package:icm_app_2/util/auxiliar.dart';
import 'package:icm_app_2/util/db_helper.dart';
import 'package:icm_app_2/util/routes.dart';
import 'package:icm_app_2/util/storage.dart';

class VisitaController extends GetxController {
  final MyCameraController cCtrl = Get.find();
  var editId = 0;

  var lstArea = <DropdownMenuItem<String>>[].obs;
  var lstCens = <DropdownMenuItem<String>>[].obs;
  var lstQuart = <DropdownMenuItem<String>>[].obs;
  var lstTipo = <DropdownMenuItem<String>>[].obs;
  var idArea = '0'.obs;
  var idCens = '0'.obs;
  var idQuart = '0'.obs;

  var loadingArea = false.obs;
  var loadingCens = false.obs;
  var loadingQuart = false.obs;
  var ordem = 1;

  var clearAll = false.obs;

  var dtCadastro = DateTime.now().toString().substring(0, 10).obs;

  var idTipo = '1'.obs;
  var fachada = 1.obs;
  var casa = 1.obs;
  var quintal = 1.obs;
  var sombraQuintal = 1.obs;
  var pavQuintal = 1.obs;
  var telhado = 1.obs;
  var recipiente = 1.obs;

  var dateController = TextEditingController().obs;

  final agenteController = TextEditingController();
  final ordemController = TextEditingController();
  final endController = TextEditingController();
  final numeroController = TextEditingController();
  final latController = TextEditingController();
  final lngController = TextEditingController();

  var visita = new Visita().obs;
  final dbHelper = DbHelper.instance;

  initObj(int id) async {
    editId = id;
    final db = DbHelper.instance;

    var json = await db.queryObj('visita', id);

    updateArea(json['id_area'].toString());
    updateCens(json['id_censitario'].toString());
    updateQuart(json['id_quarteirao'].toString());
    updateTipo(json['idTipo'].toString());

    var dt = json['dt_cadastro'].split('-');
    var formattedDate =
        dt[2] + '-' + dt[1].padLeft(2, '0') + '-' + dt[0].padLeft(2, '0');
    dtCadastro.value = formattedDate; //json['dt_cadastro'];
    dateController.value.text = json['dt_cadastro']; //dtCadastro.value;
    agenteController.text = json['agente'].toString();
    ordemController.text = json['ordem'].toString();
    endController.text = json['endereco'].toString();
    numeroController.text = json['numero'].toString();
    fachada.value = int.parse(json['fachada'].toString());
    casa.value = int.parse(json['casa'].toString());
    quintal.value = int.parse(json['quintal'].toString());
    sombraQuintal.value = int.parse(json['sombra_quintal'].toString());
    pavQuintal.value = int.parse(json['pav_quintal'].toString());
    telhado.value = int.parse(json['telhado'].toString());
    recipiente.value = int.parse(json['recipiente'].toString());
    latController.text = json['latitude'].toString();
    lngController.text = json['longitude'].toString();
    cCtrl.arquivo = File(json['foto'].toString());
    cCtrl.hasFile.value = true;
  }

  Future<void> getPosition() async {
    /* Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    this.latController.text = pos.latitude.toString();
    this.lngController.text = pos.longitude.toString();*/
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5,
    );

    StreamSubscription positionStream =
        await Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position pos) {
      this.latController.text = pos.latitude.toString();
      this.lngController.text = pos.longitude.toString();
    });
  }

  loadPreferences() async {
    try {
      this.agenteController.text = await Storage.recupera('agente');
      this.ordemController.text = this.ordem.toString();
    } catch (e) {}
  }

  alterFachada(val) {
    if (val == 'p') {
      this.fachada++;
    } else if (val == 'm') {
      this.fachada--;
    }
  }

  alterCasa(val) {
    if (val == 'p') {
      this.casa++;
    } else if (val == 'm') {
      this.casa--;
    }
  }

  alterQuintal(val) {
    if (val == 'p') {
      this.quintal++;
    } else if (val == 'm') {
      this.quintal--;
    }
  }

  alterSombraQuintal(val) {
    if (val == 'p') {
      this.sombraQuintal++;
    } else if (val == 'm') {
      this.sombraQuintal--;
    }
  }

  alterPavQuintal(val) {
    if (val == 'p') {
      this.pavQuintal++;
    } else if (val == 'm') {
      this.pavQuintal--;
    }
  }

  alterTelhado(val) {
    if (val == 'p') {
      this.telhado++;
    } else if (val == 'm') {
      this.telhado--;
    }
  }

  alterRecipiente(val) {
    if (val == 'p') {
      this.recipiente++;
    } else if (val == 'm') {
      this.recipiente--;
    }
  }

  doRegister() async {
    this.visita.value.agente = this.agenteController.value.text;
    this.visita.value.dtCadastro = dateController.value.text;
    this.visita.value.idTipo = this.idTipo.value;
    try {
      Storage.insere('agente', this.agenteController.value.text);
    } catch (ex) {}
    Get.toNamed(Routes.VISITA);
  }

  doPost(BuildContext context, File file) async {
    this.visita.value.idMunicipio = await Storage.recupera('id_municipio');
    this.visita.value.ordem = this.ordemController.text;
    this.visita.value.endereco = this.endController.text;
    this.visita.value.numero = this.numeroController.text;

    this.visita.value.fachada = this.fachada.value;
    this.visita.value.casa = this.casa.value;
    this.visita.value.quintal = this.quintal.value;
    this.visita.value.sombraQuintal = this.sombraQuintal.value;
    this.visita.value.pavQuintal = this.pavQuintal.value;
    this.visita.value.telhado = this.telhado.value;
    this.visita.value.recipiente = this.recipiente.value;
    this.visita.value.latitude = this.latController.text;
    this.visita.value.longitude = this.lngController.text;
    this.visita.value.foto = file.path;

    Map<String, dynamic> row = new Map();
    row['id_municipio'] = this.visita.value.idMunicipio;
    row['id_area'] = this.visita.value.idArea;
    row['id_censitario'] = this.visita.value.idCensitario;
    row['id_quarteirao'] = this.visita.value.idQuarteirao;
    row['dt_cadastro'] = this.visita.value.dtCadastro;
    row['agente'] = this.visita.value.agente;

    row['ordem'] = this.visita.value.ordem;
    row['endereco'] = this.visita.value.endereco;
    row['numero'] = this.visita.value.numero;
    row['idTipo'] = this.visita.value.idTipo;
    row['fachada'] = this.visita.value.fachada;
    row['casa'] = this.visita.value.casa;
    row['quintal'] = this.visita.value.quintal;
    row['sombra_quintal'] = this.visita.value.sombraQuintal;
    row['pav_quintal'] = this.visita.value.pavQuintal;
    row['telhado'] = this.visita.value.telhado;
    row['recipiente'] = this.visita.value.recipiente;
    row['latitude'] = this.visita.value.latitude;
    row['longitude'] = this.visita.value.longitude;
    row['foto'] = this.visita.value.foto;
    row['status'] = 0;

    int id = 0;

    if (editId == 0) {
      id = await dbHelper.insert(row, 'visita');
    } else {
      await dbHelper.update(row, 'visita', editId);
    }

    cCtrl.hasFile.value = false;
    cCtrl.initImage();

    if (id > 0) {
      this.ordem++;
      doClear();
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: const Text('Registro inserido.'),
          backgroundColor: Colors.green[900],
        ),
      );
    } else {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: const Text('Registro atualizado.'),
          backgroundColor: Colors.green[900],
        ),
      );
      Get.to(Routes.CONSULTA);
    }
  }

  doClear() {
    this.ordemController.text = this.ordem.toString();
    this.numeroController.text = '';
    this.fachada.value = 1;
    this.casa.value = 1;
    this.quintal.value = 1;
    this.sombraQuintal.value = 1;
    this.pavQuintal.value = 1;
    this.telhado.value = 1;
    this.recipiente.value = 1;

    /*
    this.visita.value.ordem = '';
    this.visita.value.endereco = '';
    this.visita.value.numero = '';
    this.visita.value.fachada = 0;
    this.visita.value.casa = 0;
    this.visita.value.quintal = 0;
    this.visita.value.sombraQuintal = 0;
    this.visita.value.pavQuintal = 0;
    this.visita.value.telhado = 0;
    this.visita.value.recipiente = 0;
    this.visita.value.latitude = '';
    this.visita.value.longitude = '';
    */
  }

  getCurrentDate(String date) async {
    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    this.dateController.value.text = formattedDate;
    this.dtCadastro.value = formattedDate.toString();
  }

  loadArea() {
    this.loadingArea.value = true;
    Auxiliar.loadData('area', '').then((value) {
      this.lstArea.value = value;
      this.loadingArea.value = false;
    });
  }

  loadTypes() {
    this.lstTipo.value = [
      DropdownMenuItem(
        child: Text("Casa"),
        value: '1',
      ),
      DropdownMenuItem(
        child: Text("Comércio"),
        value: '2',
      ),
      DropdownMenuItem(child: Text("Indústria"), value: '3'),
      DropdownMenuItem(child: Text("Prédio de apartamentos"), value: '4'),
      DropdownMenuItem(child: Text("Outros"), value: '5'),
    ];
  }

  updateArea(value) {
    this.loadingCens.value = true;
    this.visita.value.idArea = value;
    this.idArea.value = value;
    Auxiliar.loadData('censitario', ' id_area= ' + value).then((value) {
      this.lstCens.value = value;
      this.loadingCens.value = false;
    });
  }

  updateCens(value) {
    this.visita.value.idCensitario = value;
    this.idCens.value = value;
    this.loadingQuart.value = true;
    Auxiliar.loadData('quarteirao', ' id_censitario= ' + value).then((value) {
      this.lstQuart.value = value;
      this.loadingQuart.value = false;
    });
  }

  updateQuart(value) {
    this.visita.value.idQuarteirao = value;
    this.idQuart.value = value;
  }

  updateTipo(value) {
    value = value == null ? '1' : value;
    this.visita.value.idTipo = value;
    this.idTipo.value = value;
  }

  limpaVisitas(BuildContext context) async {
    final db = DbHelper.instance;
    var tipo = clearAll.value ? 1 : 2;
    var qt = 0;
    db.limpaVisita(tipo).then((value) {
      qt = value;
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: Text(qt.toString() + ' registros excluidos.'),
          backgroundColor: Colors.green[900],
        ),
      );
    });
  }
}
