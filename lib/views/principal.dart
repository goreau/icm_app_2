import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icm_app_2/colors-constants.dart';
import 'package:icm_app_2/util/routes.dart';

class Principal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ICM App vs.2'),
        backgroundColor: COR_AZUL,
      ),
      body: new Container(      
        child: new Image.asset('assets/images/casa.png'),
        alignment: Alignment.center,
      ),
      drawer: Container(
        width: 250,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                height: 100,
                child: DrawerHeader(
                  child: ListTile(
                    leading: SizedBox(child: Image.asset('assets/images/casa.png'),width: 30,height: 30,),
                    title: Text('ICM App', style: TextStyle(fontSize: 18, color: COR_BRANCO, fontWeight: FontWeight.bold),),
                    subtitle: Text('Condição de Moradias', style: TextStyle(fontSize: 12, color: COR_BRANCO, fontWeight: FontWeight.bold),),
                  ),
                  decoration: BoxDecoration(color: COR_AZUL_MARINHO),
                ),
              ),
              Container(
                height: 40,
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text(
                    'Início',
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {
                    Get.toNamed(Routes.HOME);
                  },
                ),
              ),
              Container(
                height: 5,
                child: Divider(
                  color: Colors.blue,
                ),
              ),
              Container(
                height: 40,
                child: ListTile(
                  title: Text(
                    'Atividades',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              Container(
                height: 40,
                child: ListTile(
                  leading: Icon(Icons.home_work_outlined),
                  title: Text(
                    'Registrar',
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {
                    //Navigator.of(context).pushNamed(Routes.ATIVIDADE);
                    Get.toNamed(Routes.ATIVIDADE);
                  },
                ),
              ),
              Container(
                height: 40,
                child: ListTile(
                  leading: Icon(Icons.assignment_outlined),
                  title: Text(
                    'Consultar',
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {
                    Get.toNamed(Routes.CONSULTA);
                  },
                ),
              ),
              Container(
                height: 40,
                child: ListTile(
                  leading: Icon(Icons.plumbing_outlined),
                  title: Text(
                    'Manutenção',
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {
                    Get.toNamed(Routes.LIMPEZA);
                  },
                ),
              ),
              Container(
                height: 10,
                child: Divider(
                  color: Colors.blue,
                ),
              ),
              Container(
                height: 40,
                child: ListTile(
                  title: Text(
                    'Comunicação',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              Container(
                height: 40,
                child: ListTile(
                  leading: Icon(Icons.share),
                  title: Text(
                    'Exportar Produção',
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {
                    Get.toNamed(Routes.COM_EXPORTA);
                  },
                ),
              ),
              Container(
                height: 40,
                child: ListTile(
                  leading: Icon(Icons.cloud),
                  title: Text(
                    'Importar Cadastro',
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {
                    Get.toNamed(Routes.COM_IMPORTA);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
