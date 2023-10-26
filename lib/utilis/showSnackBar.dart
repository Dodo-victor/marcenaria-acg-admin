import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showSnackBar({required String content, required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      duration: const Duration(seconds: 5),
    ),
  );
}
