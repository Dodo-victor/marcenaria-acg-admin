import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utilis/colors.dart';

class Loader extends StatelessWidget {
  final double? heigth;
  final double? width;
  final double? elevation;
  final Color? color;
  final bool withDialog;

  const Loader(
      {Key? key,
      this.heigth,
      this.width,
      this.color,
      this.withDialog = false,
      this.elevation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return withDialog == true
        ? Dialog(
            elevation: elevation ?? 20,
            child: SizedBox(
              height: 80,
              width: 10,
              child: SpinKitWaveSpinner(
                color: color ?? ColorsApp.primaryTheme,
                size: 20,
              ),
            ),
          )
        : SpinKitWaveSpinner(
            color: color ?? ColorsApp.primaryTheme,
            size: 20,
          );
  }
}
