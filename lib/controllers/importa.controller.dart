import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icm_app_2/models/municipio.dart';
import 'package:icm_app_2/util/comunica.service.dart';
import 'package:icm_app_2/util/municipios.dart';
import 'package:icm_app_2/util/storage.dart';

class ImportaController extends GetxController {
  var retorno = ''.obs;
  var loading = false.obs;
  late List<Municipio> municipioList;

  ComunicaService _com = new ComunicaService();

  @override
  void onInit(){
    super.onInit();
    municipioList = municipios;
  }

  Future<void> loadCadastro(BuildContext context, int mun) async {
    loading.value = true;
    
    try {
      Storage.insere('id_municipio', mun);
      retorno.value = await _com.getCadastro(context, mun);
    } catch (Exception) {
      retorno.value = 'Erro criando lista:' + Exception.toString();
    }
    loading.value = false;
  }
}
