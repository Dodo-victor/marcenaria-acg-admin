import 'package:acg_admin/utilis/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showSelectImageOption(
    {required BuildContext context, VoidCallback? captureFromcamera, VoidCallback? selectFromGallery}) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        final size = MediaQuery
            .of(context)
            .size;

        return SizedBox(
          height: size.height * 0.3,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Selecionar uma imagem",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Center(
                  child: Divider(
                    indent: 90,
                    endIndent: 90,
                    thickness: 4,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: captureFromcamera,
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: ColorsApp.primaryTheme,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.camera_alt_rounded),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text("Tirar uma fotográfia",
                        style: TextStyle(fontSize: 20),),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: selectFromGallery,
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: ColorsApp.primaryTheme,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.photo_album),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text("Selecionar da galéria",
                          style: TextStyle(fontSize: 20)),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });
}
