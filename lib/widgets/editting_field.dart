import 'package:flutter/material.dart';

import 'loader.dart';

class EdittingField extends StatelessWidget {
  final TextEditingController? controller;
  final bool isEditingName;
  final bool isEditting;
  final bool loader;
  final VoidCallback? isEdittingFunc;
  final VoidCallback? updateData;
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
      this.constraints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Colors.grey.shade500,
      ),
      child: loader
          ? const Loader()
          : TextField(
              controller: controller,
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
                                  color: isEditingName
                                      ? Colors.grey.shade200
                                      : null),
                            )
                      : InkWell(
                          onTap: isEdittingFunc,
                          child: Icon(Icons.edit,
                              color:
                                  isEditingName ? Colors.grey.shade200 : null),
                        ),
                  border: InputBorder.none,
                  constraints: constraints),
            ),
    );
  }
}
