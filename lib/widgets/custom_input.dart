import 'package:acg_admin/utilis/colors.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController? controller;
  final String title;

  const CustomInput({Key? key, this.controller, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: ColorsApp.googleSignInColor
      ),
      child: TextFormField(
        controller: controller,

        decoration: InputDecoration(
          hintText: title,



        ),
      ),
    );
  }
}
