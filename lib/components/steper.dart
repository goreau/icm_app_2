import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icm_app_2/controllers/visita.controller.dart';

// ignore: must_be_immutable
class CustomStepper extends StatelessWidget {
  final VisitaController ctrl = Get.find();

  CustomStepper({
    //required this.lowerLimit,
    //required this.upperLimit,
    //required this.stepValue,
    required this.iconSize,
    //required this.value,
    required this.controle,
  });

  //final int lowerLimit;
  //final int upperLimit;
  //final int stepValue;
  final double iconSize;
  final int controle;
  //int value;

  @override
  Widget build(BuildContext context) {
    if (this.controle == 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Fachada:'),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => RoundedIconButton(
                  icon: Icons.arrow_upward_sharp,
                  iconSize: this.iconSize,
                  onPress: ctrl.fachada.value < 5
                      ? () => {ctrl.alterFachada('p')}
                      : () {},
                ),
              ),
              Center(
                child: Obx(() => Text(ctrl.fachada
                    .toString())), //ctrl.visita.value.quintal.toString()
              ),
              Obx(
                () => RoundedIconButton(
                  icon: Icons.arrow_downward,
                  iconSize: this.iconSize,
                  onPress: ctrl.fachada.value > 1
                      ? () => {ctrl.alterFachada('m')}
                      : () {},
                ),
              ),
            ],
          ),
        ],
      );
    } else if (this.controle == 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Casa:'),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => RoundedIconButton(
                  icon: Icons.arrow_upward_sharp,
                  iconSize: this.iconSize,
                  onPress:
                      ctrl.casa.value < 5 ? () => {ctrl.alterCasa('p')} : () {},
                ),
              ),
              Center(
                child: Obx(() => Text(ctrl.casa
                    .toString())), //ctrl.visita.value.quintal.toString()
              ),
              Obx(
                () => RoundedIconButton(
                  icon: Icons.arrow_downward,
                  iconSize: this.iconSize,
                  onPress:
                      ctrl.casa.value > 1 ? () => {ctrl.alterCasa('m')} : () {},
                ),
              ),
            ],
          ),
        ],
      );
    } else if (this.controle == 3) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Quintal:'),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => RoundedIconButton(
                  icon: Icons.arrow_upward_sharp,
                  iconSize: this.iconSize,
                  onPress: ctrl.quintal.value < 5
                      ? () => {ctrl.alterQuintal('p')}
                      : () {},
                ),
              ),
              Center(
                child: Obx(() => Text(ctrl.quintal
                    .toString())), //ctrl.visita.value.quintal.toString()
              ),
              Obx(
                () => RoundedIconButton(
                  icon: Icons.arrow_downward,
                  iconSize: this.iconSize,
                  onPress: ctrl.quintal.value > 1
                      ? () => {ctrl.alterQuintal('m')}
                      : () {},
                ),
              ),
            ],
          ),
        ],
      );
    } else if (this.controle == 4) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Sombra no Quintal:'),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => RoundedIconButton(
                  icon: Icons.arrow_upward_sharp,
                  iconSize: this.iconSize,
                  onPress: ctrl.sombraQuintal.value < 5
                      ? () => {ctrl.alterSombraQuintal('p')}
                      : () {},
                ),
              ),
              Center(
                child: Obx(() => Text(ctrl.sombraQuintal
                    .toString())), //ctrl.visita.value.quintal.toString()
              ),
              Obx(
                () => RoundedIconButton(
                  icon: Icons.arrow_downward,
                  iconSize: this.iconSize,
                  onPress: ctrl.sombraQuintal.value > 1
                      ? () => {ctrl.alterSombraQuintal('m')}
                      : () {},
                ),
              ),
            ],
          ),
        ],
      );
    } else if (this.controle == 5) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Pavimentação no Quintal:'),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => RoundedIconButton(
                  icon: Icons.arrow_upward_sharp,
                  iconSize: this.iconSize,
                  onPress: ctrl.pavQuintal.value < 5
                      ? () => {ctrl.alterPavQuintal('p')}
                      : () {},
                ),
              ),
              Center(
                child: Obx(() => Text(ctrl.pavQuintal
                    .toString())), //ctrl.visita.value.quintal.toString()
              ),
              Obx(
                () => RoundedIconButton(
                  icon: Icons.arrow_downward,
                  iconSize: this.iconSize,
                  onPress: ctrl.pavQuintal.value > 1
                      ? () => {ctrl.alterPavQuintal('m')}
                      : () {},
                ),
              ),
            ],
          ),
        ],
      );
    } else if (this.controle == 6) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Telhado:'),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => RoundedIconButton(
                  icon: Icons.arrow_upward_sharp,
                  iconSize: this.iconSize,
                  onPress: ctrl.telhado.value < 3
                      ? () => {ctrl.alterTelhado('p')}
                      : () {},
                ),
              ),
              Center(
                child: Obx(() => Text(ctrl.telhado
                    .toString())), //ctrl.visita.value.quintal.toString()
              ),
              Obx(
                () => RoundedIconButton(
                  icon: Icons.arrow_downward,
                  iconSize: this.iconSize,
                  onPress: ctrl.telhado.value > 1
                      ? () => {ctrl.alterTelhado('m')}
                      : () {},
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Recipientes:'),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => RoundedIconButton(
                  icon: Icons.arrow_upward_sharp,
                  iconSize: this.iconSize,
                  onPress: ctrl.recipiente.value < 2
                      ? () => {ctrl.alterRecipiente('p')}
                      : () {},
                ),
              ),
              Center(
                child: Obx(() => Text(ctrl.recipiente
                    .toString())), //ctrl.visita.value.quintal.toString()
              ),
              Obx(
                () => RoundedIconButton(
                  icon: Icons.arrow_downward,
                  iconSize: this.iconSize,
                  onPress: ctrl.recipiente.value > 1
                      ? () => {ctrl.alterRecipiente('m')}
                      : () {},
                ),
              ),
            ],
          ),
        ],
      );
    }
  }
}

class RoundedIconButton extends StatelessWidget {
  RoundedIconButton({
    required this.icon,
    required this.onPress,
    required this.iconSize,
  });

  final IconData icon;
  final VoidCallback onPress;
  //final Function onPress;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints:
          BoxConstraints.tightFor(width: this.iconSize, height: this.iconSize),
      elevation: 6.0,
      onPressed: this.onPress,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * 0.2)),
      fillColor: Color(0xFF65A34A),
      child: Icon(
        this.icon,
        color: Colors.white,
        size: this.iconSize * 0.8,
      ),
    );
  }
}
