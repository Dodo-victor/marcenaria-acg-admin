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

  const EdittingField(
      {Key? key,
      this.controller,
      this.isEditingName = true,
      this.isEditting = false,
      this.isEdittingFunc,
      this.updateData,
      this.color,
      this.loader = false})
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
                  border: InputBorder.none),
            ),
    );
  }
}
