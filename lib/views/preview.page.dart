import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icm_app_2/colors-constants.dart';

class PreviewPage extends StatelessWidget {
  PreviewPage({ Key? key, required this.file }) : super(key: key);

  File file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.file(file, fit: BoxFit.cover,),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: COR_AZUL_MARINHO.withOpacity(0.5),
                          child: IconButton(
                            onPressed: ()=>{ Get.back(result: file), }, 
                            icon: Icon(Icons.check, color: COR_BRANCO, size: 30,),),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: COR_AZUL_MARINHO.withOpacity(0.5),
                          child: IconButton(
                            onPressed: ()=>{ Get.back(), }, 
                            icon: Icon(Icons.close, color: COR_BRANCO, size: 30,),),
                        ),
                      ),
                    )
                ],),
              ],) 
          )
        ],
      ),
    );
  }
}