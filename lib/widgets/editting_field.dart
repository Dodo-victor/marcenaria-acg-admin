import 'package:flutter/material.dart';

import 'loader.dart';

class EdittingField extends StatelessWidget {
  final TextEditingController? controller;
  final bool isEditingName;
  final bool isEditting;
  final bool loader;
  final bool withInitialValue;
  final VoidCallback? isEdittingFunc;
  final VoidCallback? updateData;
  final String? initialValue;
  final Color? color;
  final int? maxLines;
  final int? minLines;
  final BoxConstraints? constraints;
  final bool isExpands;

  const EdittingField(
      {Key? key,
      this.controller,
      this.isEditingName = true,
      this.isEditting = false,
      this.isEdittingFunc,
      this.updateData,
      this.color,
      this.loader = false,
      this.isExpands = false,
      this.maxLines = 1,
      this.minLines = 1,
      this.constraints,
      this.withInitialValue = false,
      this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _inputWithInitialValue() {
      if (!withInitialValue) {
        return TextFormField(
          controller: controller,
          readOnly: isEditingName,
          initialValue: initialValue,
          maxLines: maxLines,
          minLines: minLines,
          expands: isExpands,
          decoration: InputDecoration(
              suffixIcon: !isEditingName
                  ? isEditting
                      ? const Loader()
                      : InkWell(
                          onTap: updateData,
                          child: Icon(Icons.done_outlined,
                              color:
                                  isEditingName ? Colors.grey.shade200 : null),
                        )
                  : InkWell(
                      onTap: isEdittingFunc,
                      child: Icon(Icons.edit,
                          color: isEditingName ? Colors.grey.shade200 : null),
                    ),
              border: InputBorder.none,
              constraints: constraints),
        );
      } else {
        return TextFormField(
          //controller: controller,
          readOnly: isEditingName,
          maxLines: maxLines,
          minLines: minLines,
          expands: isExpands,
          decoration: InputDecoration(
              suffixIcon: !isEditingName
                  ? isEditting
                      ? const Loader()
                      : InkWell(
                          onTap: updateData,
                          child: Icon(Icons.done_outlined,
                              color:
                                  isEditingName ? Colors.grey.shade200 : null),
                        )
                  : InkWell(
                      onTap: isEdittingFunc,
                      child: Icon(Icons.edit,
                          color: isEditingName ? Colors.grey.shade200 : null),
                    ),
              border: InputBorder.none,
              constraints: constraints),
        );
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: color ?? Colors.grey.shade500,
      ),
      child: loader
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _inputWithInitialValue(),
            ),
    );
  }
}
