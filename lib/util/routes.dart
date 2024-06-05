import 'package:get/get.dart';
import 'package:icm_app_2/util/sample.bind.dart';
import 'package:icm_app_2/views/atividade.dart';
import 'package:icm_app_2/views/com_envio.dart';
import 'package:icm_app_2/views/com_importa.dart';
import 'package:icm_app_2/views/consulta/consulta.dart';
import 'package:icm_app_2/views/manutencao.dart';
import 'package:icm_app_2/views/principal.dart';
import 'package:icm_app_2/views/splash.dart';
import 'package:icm_app_2/views/visita.dart';

class Routes {
  static const SPLASH = '/';
  static const HOME = '/home';
  static const COM_IMPORTA = '/com_importa';
  static const COM_EXPORTA = '/com_exporta';
  static const ATIVIDADE = '/atividade';
  static const VISITA = '/visita';
  static const CONSULTA = '/consulta';
  static const LIMPEZA = '/limpeza';
}

List<GetPage<dynamic>> rotas = [
  GetPage(name: Routes.SPLASH, page: () => SplashPage()),
  GetPage(name: Routes.HOME, page: () => Principal()),
  GetPage(name: Routes.COM_IMPORTA, page: () => ComImporta()),
  GetPage(name: Routes.COM_EXPORTA, page: () => ComExporta()),
  GetPage(
      name: Routes.ATIVIDADE, page: () => Atividade(), binding: SampleBind()),
  GetPage(name: Routes.VISITA, page: () => ViewVisita(), binding: SampleBind()),
  GetPage(name: Routes.CONSULTA, page: () => Consulta()),
  GetPage(
      name: Routes.LIMPEZA,
      page: () => ManutencaoView(),
      binding: SampleBind()),
];
