import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:icm_app_2/components/foto.dart';
import 'package:icm_app_2/views/preview.page.dart';
import 'package:path_provider/path_provider.dart';

class MyCameraController extends GetxController {
  late File arquivo;
  final hasFile = false.obs;
  //var editPath = ''.obs;

  MyCameraController() {
    initImage();
  }

  initImage() async {
    await getImageFileFromAssets().then((value) {
      if (!hasFile.value) {
        arquivo = value;
        hasFile.value = true;
      }
    });
  }

  tirarFoto(file) async {
    hasFile.value = false;
    file = await Get.to(() => PreviewPage(file: file));
    if (file != null) {
      arquivo = file;
      hasFile.value = true;
      Get.back();
    }
  }

  Widget showFoto() {
    return hasFile.value ? Foto(file: arquivo, size: 100) : Text('Imagem não disponível');
  }

  Future<File> getImageFileFromAssets() async {
   // var assets = await rootBundle.loadString('AssetManifest.json');

    String path = 'images/nd.png';
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/nd.png');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }
}
