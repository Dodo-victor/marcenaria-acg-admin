import 'package:acg_admin/utilis/colors.dart';
import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback? function;
  final double? height;
  final double? width;

  const GoogleSignInButton({super.key, this.function, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(

        height: height ?? 55,
        width: width ?? 400,
        decoration: BoxDecoration(
          color: ColorsApp.googleSignInColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/google.png", height: 35,),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "Entrar com google",
              style: TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
