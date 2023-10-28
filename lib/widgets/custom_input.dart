import 'package:acg_admin/utilis/colors.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController? controller;
  final String title;
  final BoxConstraints? constraints;
  final bool isExpands;

  const CustomInput(
      {Key? key,
      this.controller,
      required this.title,
      this.constraints,
      this.isExpands = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(color: ColorsApp.googleSignInColor),
      child: TextFormField(
        controller: controller,
        expands: isExpands,
        decoration: InputDecoration(
            hintText: title,
            constraints: constraints,
            border: InputBorder.none),
      ),
    );
  }
}
