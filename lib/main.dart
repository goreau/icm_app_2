import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icm_app_2/util/routes.dart';

import 'colors-constants.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'IcmApp 2',
      theme: buildThemeData(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: rotas,
    );
  }
}

ThemeData buildThemeData() {
  final baseTheme = ThemeData.light();
  return baseTheme.copyWith(
    primaryColor: COR_AZUL_MARINHO,
    primaryTextTheme: TextTheme(
        headline6: TextStyle(
          color: COR_BRANCO,
        )),
    primaryIconTheme: IconThemeData(color: COR_BRANCO),
    textTheme: baseTheme.textTheme.copyWith(
      bodyText1: TextStyle(
        color: COR_AZUL_MARINHO,
      ),
      bodyText2: TextStyle(
        color: COR_AZUL_MARINHO,
      ),
      headline6: TextStyle(
        fontSize: 20,
        fontFamily: 'RobotoCondensed',
        fontWeight: FontWeight.w100,
      ),
    ),
  );
}
