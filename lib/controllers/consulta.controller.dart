import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icm_app_2/models/visita.dart';
import 'package:icm_app_2/util/db_helper.dart';
import 'package:icm_app_2/views/consulta/consulta-tile.dart';

class ConsultaController extends GetxController {
  var loaded = false.obs;
  List<LstMaster> itens = [];
  List<LstDetail> dets = [];

  ConsultaController() {
    inicio();
  }

  Future<void> inicio() async {
    await loadItens();
  }

  Future<void> loadItens() async {
    try {
      final db = DbHelper.instance;

      itens = await db.consultaVisitasMaster();
      loaded.value = true;
    } catch (ex) {
      print('Erro criando lista' + ex.toString());
    }
  }

  Future<List<LstDetail>> loadDetails(id) async {
    List<LstDetail> dt = [];
    try {
      final db = DbHelper.instance;
      dt = await db.consultaVisitasDetail(id);
    } catch (ex) {
      print('Erro criando lista' + ex.toString());
    }

    return dt;
  }

  excluiVisita(vis) {
    final db = DbHelper.instance;
    db.delete(vis, 'visita');
    
    Get.back(closeOverlays: true);
    Get.toNamed('/consulta');
  }

  List<Widget> getDetail(int id) {
    List<Widget> childs = [];
    loadDetails(id).then((value) {
      value.forEach((element) {
        childs.add(ConsultaTile(element));
      });
      return childs;
    });
    return childs;
  }
}
