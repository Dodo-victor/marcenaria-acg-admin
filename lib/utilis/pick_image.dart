// ignore_for_file: use_build_context_synchronously

import 'package:acg_admin/utilis/showSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

captureImage(
    {required ImageSource source, required BuildContext context}) async {
  final ImagePicker imagePicker = ImagePicker();

  final XFile? image = await imagePicker.pickImage(source: source);

  if (image != null) {
    return image.readAsBytes();
  } else {
    showSnackBar(
        content: "Ocorreu um erro ao pegar a imagem", context: context);
  }
}
