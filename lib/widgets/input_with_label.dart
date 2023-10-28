import 'package:flutter/material.dart';

import 'custom_input.dart';

class InputWithLabel extends StatelessWidget {
  final String productName;
  final String hintText;
  final BoxConstraints? constraints;
  final bool isExpands;
  final String? Function(String?)? validator;

  const InputWithLabel({
    Key? key,
    required this.productName,
    required this.hintText,
    this.constraints,
    this.isExpands = false, this.validator,
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
          title: hintText,
          constraints: constraints,
          isExpands: isExpands,
          validator: validator,
        ),
      ],
    );
  }
}
