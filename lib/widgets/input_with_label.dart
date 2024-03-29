import 'package:flutter/material.dart';

import 'custom_input.dart';

class InputWithLabel extends StatelessWidget {
  final String productName;
  final TextEditingController? controller;
  final String hintText;
  final BoxConstraints? constraints;
  final bool isExpands;
  final int? maxLines;
  final int? minLines;
  final String? Function(String?)? validator;

  const InputWithLabel({
    Key? key,
    required this.productName,
    required this.hintText,
    this.constraints,
    this.isExpands = false,
    this.validator,
    this.controller,
    this.maxLines = 1,
    this.minLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productName,
          style: const TextStyle(color: Colors.black45),
        ),
        const SizedBox(
          height: 5,
        ),
        CustomInput(
          maxLines: maxLines,
          minLines: minLines,
          controller: controller,
          title: hintText,
          constraints: constraints,
          isExpands: isExpands,
          validator: validator,
        ),
      ],
    );
  }
}
