import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icm_app_2/colors-constants.dart';
import 'package:icm_app_2/controllers/importa.controller.dart';
import 'package:icm_app_2/models/municipio.dart';

class ComImporta extends StatelessWidget {
  final ImportaController ctrl = Get.put(ImportaController());
  int id_mun = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Importar Cadastro'),
      ),
      body: Column(
        children: [
          Form(
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.all(16),
                      child: Autocomplete<Municipio>(
                          optionsBuilder: (textEditingValue){
                            return ctrl.municipioList
                                .where((Municipio mun) => mun.nome
                                .toLowerCase()
                                .startsWith(textEditingValue.text.toLowerCase()))
                                .toList();
                          },
                        displayStringForOption: (Municipio mun) => mun.nome,
                        fieldViewBuilder: (BuildContext context,
                            TextEditingController fieldTextEditingController,
                            FocusNode fieldFocusNode,
                            VoidCallback onFieldSubmitted){
                              return TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Selecione o município'
                                ),
                                controller: fieldTextEditingController,
                                focusNode: fieldFocusNode,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              );
                            },
                        onSelected: (Municipio sel){
                          id_mun = sel.id_municipios;
                        },
                      ),
                  ),
                ],),),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Obx(() {
                return !ctrl.loading.value == true
                    ? Container(
                        padding: EdgeInsets.all(20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              ctrl.loadCadastro(context, id_mun);
                            },
                            child: Text('Carregar'),
                            style: ElevatedButton.styleFrom(primary: COR_AZUL),
                          ),
                        ),
                      )
                    : Text('Aguarde...');
              }),
            ),
          ),
          Obx(() {
            return ctrl.loading.value == true
                ? Expanded(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [CircularProgressIndicator()]),
                  )
                : Text(ctrl.retorno.value);
          })
        ],
      ),
    );
  }
}
