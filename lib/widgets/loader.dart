import 'package:acg_admin/utilis/colors.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final double? heigth;
  final double? width;
  final Color? color;

  const Loader({Key? key, this.heigth, this.width, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: ColorsApp.primaryTheme,
    );
  }
}
