import 'package:acg_admin/utilis/colors.dart';
import 'package:acg_admin/widgets/loader.dart';
import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback? function;
  final double? height;
  final double? width;
  final bool isLoading;

  const GoogleSignInButton(
      {super.key,
      this.function,
      this.height,
      this.width,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: height ?? 55,
          width: width ?? 400,
          decoration: BoxDecoration(
            color: ColorsApp.googleSignInColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: isLoading
              ? const Center(child: Loader())
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/google.png",
                      height: 30,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      "Entrar com google",
                      style: TextStyle(
                        fontSize: 20,
                        //  fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
