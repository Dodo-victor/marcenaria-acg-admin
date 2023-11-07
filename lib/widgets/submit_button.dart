import 'package:acg_admin/utilis/colors.dart';
import 'package:acg_admin/widgets/loader.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String title;
  final bool isLoading;
  final Color? color;
  final double? height;

  final double? width;

  final BorderRadius? borderRadius;
  final TextStyle? titleStyle;
  final VoidCallback? function;

  const SubmitButton(
      {super.key,
      required this.title,
      this.isLoading = false,
      this.color,
      this.borderRadius,
      this.titleStyle,
      this.function,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        alignment: Alignment.center,
        height: height ?? 50,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: color ?? ColorsApp.primaryTheme,
          borderRadius: borderRadius ?? BorderRadius.circular(15),
        ),
        child: isLoading
            ? const Loader()
            : Text(
                title,
                style: titleStyle ??
                    TextStyle(
                      color: Colors.grey.shade200,
                      fontSize: 20,
                    ),
              ),
      ),
    );
  }
}
