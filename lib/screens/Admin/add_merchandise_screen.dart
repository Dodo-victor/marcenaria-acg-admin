import 'dart:typed_data';

import 'package:acg_admin/utilis/colors.dart';
import 'package:acg_admin/utilis/global_variables.dart';
import 'package:acg_admin/utilis/pick_image.dart';
import 'package:acg_admin/utilis/show_select_image_options.dart';
import 'package:acg_admin/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/input_with_label.dart';

class AddMerchandiseScreen extends StatefulWidget {
  const AddMerchandiseScreen({Key? key}) : super(key: key);

  @override
  State<AddMerchandiseScreen> createState() => _AddMerchandiseScreenState();
}

Uint8List? _image;

class _AddMerchandiseScreenState extends State<AddMerchandiseScreen> {
  String? _category;
  _captureImage(
      {required ImageSource source, required BuildContext context}) async {
    final image = await captureImage(source: source, context: context);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Publicar um produto"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Adicionar mercadoria",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Preencha os campos abaixo para colocar uma mercadoria a venda",
                style: TextStyle(
                  color: Colors.black45,
                ),
                // textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 5,
              ),
              Card(
                color: Colors.grey.shade200,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 150,
                        width: 150,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                          image: _image != null
                              ? DecorationImage(
                                  image: MemoryImage(_image!),
                                  fit: BoxFit.cover)
                              : null,
                        ),
                        child: InkWell(
                          onTap: () {
                            showSelectImageOption(
                                context: context,
                                selectFromGallery: () {
                                  Navigator.pop(context);
                                  _captureImage(
                                    source: ImageSource.gallery,
                                    context: context,
                                  );
                                },
                                captureFromcamera: () {
                                  Navigator.pop(context);
                                  _captureImage(
                                    source: ImageSource.camera,
                                    context: context,
                                  );
                                });
                          },
                          child: _image != null
                              ? null
                              : Container(
                                  height: 40,
                                  width: 40,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade400,
                                  ),
                                  child: Icon(
                                    Icons.camera_alt_rounded,
                                    color: Colors.grey.shade100,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputWithLabel(
                                productName: "Nome do produto*",
                                hintText: "Nome do Produto"),
                            const SizedBox(
                              height: 10,
                            ),
                            InputWithLabel(
                              productName: "Preço*",
                              hintText: "Ex: 15.000kz",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InputWithLabel(
                              productName: "Medidas*",
                              hintText: "Ex: 1m x 5",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InputWithLabel(
                              productName: "Tipo de Madeira (Opcional)",
                              hintText: "Ex: Musivi",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InputWithLabel(
                              productName: "Medidas*",
                              hintText: "Ex: 1m x 5",
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Card(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: InputWithLabel(
                        productName: "Descrição*",
                        isExpands: false,
                        constraints: BoxConstraints.expand(height: 120),
                        hintText: "De uma informação adicional do produto",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Card(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Selecionar Categoria",
                      style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Divider(),
                    //  SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: DropdownButtonFormField(
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorsApp.primaryTheme),
                              )),
                          hint: const Text("Categoria"),
                          items: GlobalVariables.category.map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _category = value;
                            });
                          }),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
