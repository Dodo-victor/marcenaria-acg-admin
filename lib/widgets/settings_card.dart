import 'package:flutter/material.dart';

import '../utilis/colors.dart';

class SettingsCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final double? iconSize;

  final double? height;
  final VoidCallback? function;
  final double? width;
  final TextStyle? titleStyle;

  const SettingsCard(
      {Key? key,
      required this.title,
      required this.icon,
      this.height,
      this.width,
      this.titleStyle,
      this.iconSize,
      this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        height: height ?? 100,
        width: width ?? 100,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: ColorsApp.googleSignInColor,
            borderRadius: BorderRadius.circular(15)),
        child: FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: iconSize ?? 30,
                color: Colors.grey.shade900,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: titleStyle ??
                    Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: Colors.black45),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
