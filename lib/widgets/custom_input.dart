import 'package:acg_admin/utilis/colors.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController? controller;
  final String title;
  final BoxConstraints? constraints;
  final bool isExpands;
  final String? Function(String?)? validator;

  const CustomInput({Key? key,
    this.controller,
    required this.title,
    this.constraints,
    this.isExpands = false, this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(color: ColorsApp.googleSignInColor),
      child: TextFormField(
        controller: controller,
        expands: isExpands,
        validator: validator,

        decoration: InputDecoration(
          hintText: title,
          hintStyle: const TextStyle(color: Colors.black45, fontSize: 12),
          constraints: constraints,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(

            borderSide: BorderSide(color: ColorsApp.primaryTheme,

            ),
            borderRadius: BorderRadius.circular(0),
          )

        ),
      ),
    );
  }
}
