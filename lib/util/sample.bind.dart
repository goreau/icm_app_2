import 'package:get/get.dart';
import 'package:icm_app_2/controllers/camera.controller.dart';
import 'package:icm_app_2/controllers/visita.controller.dart';

class SampleBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisitaController>(() => VisitaController());
    Get.lazyPut<MyCameraController>(() => MyCameraController());
  }
}
