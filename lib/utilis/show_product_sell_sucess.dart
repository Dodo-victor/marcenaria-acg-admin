import 'package:flutter/material.dart';

showProductSellSuccess(
    {required context,
    double? height,
    double? width,
    double? radius,
    String? title,
    String? content,
    Widget? onEvent}) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 20,
          surfaceTintColor: Colors.white,
          child: SizedBox(
            height: height ?? 280,
            width: width ?? 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                onEvent ??
                    Container(
                      height: radius ?? 65,
                      width: radius ?? 65,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(190),
                      ),
                      child: Icon(
                        Icons.done,
                        color: Colors.grey.shade100,
                        size: 35,
                      ),
                    ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Parabéns",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Você marcou este produto como vendido",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.black45,
                      ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        );
      });
}
