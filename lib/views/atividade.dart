import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icm_app_2/colors-constants.dart';
import 'package:icm_app_2/controllers/visita.controller.dart';

class Atividade extends StatelessWidget {
  final VisitaController ctrl = Get.find();
  final int ano = DateTime.parse(new DateTime.now().toString()).year;

  final id = Get.arguments;

  @override
  Widget build(BuildContext context) {
    if (id != null) {
      ctrl.initObj(id);
    }
    ctrl.loadArea();
    ctrl.loadTypes();
    ctrl.loadPreferences();

    return Scaffold(
      appBar: new AppBar(
        title: const Text('Registrar Atividade'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Form(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.map_sharp),
                    title: Text(
                      'Área:',
                      style: new TextStyle(
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    subtitle: Obx(
                      () => ((ctrl.loadingArea.value)
                          ? Center(child: CircularProgressIndicator())
                          : DropdownButton<String>(
                              hint: Text(''),
                              value: ctrl.idArea.value,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              isExpanded: true,
                              items: ctrl.lstArea,
                              onChanged: (value) {
                                ctrl.updateArea(value);
                              },
                            )),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.map_outlined),
                    title: Text(
                      'Censitário:',
                      style: new TextStyle(
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    subtitle: Obx(
                      () => ((ctrl.loadingCens.value)
                          ? Center(child: CircularProgressIndicator())
                          : DropdownButton<String>(
                              hint: Text('Censitário'),
                              value: ctrl.idCens.value,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              isExpanded: true,
                              items: ctrl.lstCens,
                              onChanged: (value) {
                                ctrl.updateCens(value);
                              },
                            )),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.crop_outlined),
                    title: Text(
                      'Quarteirão:',
                      style: new TextStyle(
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    subtitle: Obx(
                      () => ((ctrl.loadingQuart.value)
                          ? Center(child: CircularProgressIndicator())
                          : DropdownButton<String>(
                              hint: Text('Quarteirão'),
                              value: ctrl.idQuart.value,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              isExpanded: true,
                              items: ctrl.lstQuart,
                              onChanged: (value) {
                                ctrl.updateQuart(value);
                              },
                            )),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: Obx(
                      () => (TextFormField(
                        style: new TextStyle(
                          fontSize: 12,
                        ),
                        readOnly: true,
                        controller: ctrl.dateController.value,
                        decoration:
                            InputDecoration(hintText: 'Data da Atividade'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'A data é obrigatória!!';
                          } else {
                            return null;
                          }
                        },
                        onSaved: null,
                        onTap: () async {
                          var date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.parse(ctrl.dtCadastro.value),
                            firstDate: DateTime(ano - 2),
                            lastDate: DateTime(ano + 1),
                          );
                          if (date != null) {
                            await ctrl.getCurrentDate(
                                date.toString().substring(0, 10));
                            date.toString().substring(0, 10);
                          }
                        },
                      )),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.accessibility),
                    title: TextFormField(
                      style: new TextStyle(
                        fontSize: 12,
                      ),
                      controller: ctrl.agenteController,
                      decoration: InputDecoration(labelText: 'Agente'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'O nome é obrigatório!!';
                        } else {
                          ctrl.visita.value.agente = value;
                          return null;
                        }
                      },
                      onSaved: null,
                    ),
                  ), //  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                          onPressed: () {
                            ctrl.doRegister();
                          },
                          child: Text('Prosseguir'),
                          style: ElevatedButton.styleFrom(primary: COR_AZUL)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<String>> loadDados(String tab) async {
  await Future.delayed(Duration(seconds: 10), () => print('Tempo ok.'));
  return ['<15', '15-20', '>20'];
}
