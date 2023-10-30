// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:acg_admin/Resources/firestore_methods.dart';
import 'package:acg_admin/models/merchandise_model.dart';
import 'package:acg_admin/utilis/colors.dart';
import 'package:acg_admin/utilis/global_variables.dart';
import 'package:acg_admin/utilis/pick_image.dart';
import 'package:acg_admin/utilis/show_select_image_options.dart';
import 'package:acg_admin/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/input_with_label.dart';
import '../../widgets/submit_button.dart';
import 'package:lottie/lottie.dart';

class AddMerchandiseScreen extends StatefulWidget {
  const AddMerchandiseScreen({Key? key}) : super(key: key);

  @override
  State<AddMerchandiseScreen> createState() => _AddMerchandiseScreenState();
}

Uint8List? _image;

class _AddMerchandiseScreenState extends State<AddMerchandiseScreen> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descrController = TextEditingController();
  final TextEditingController _medidasController = TextEditingController();
  final TextEditingController _woodtypeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String? _category;

  final FirestoreMethods _db = FirestoreMethods();

  _captureImage(
      {required ImageSource source, required BuildContext context}) async {
    final image = await captureImage(source: source, context: context);

    setState(() {
      _image = image;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _showLoader(context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Loader(
        withDialog: true,
      ),
    );
  }

  _showSuccesProductDeatils(
      {required context, required MerchandiseModel merchandiseModel}) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Produto Publicado"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                //  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Lottie.asset(
                      "assets/sucess.json",
                      height: 100,
                      width: 100,
                      alignment: Alignment.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Produto publicado com sucesso",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          merchandiseModel.photoUrl,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: merchandiseModel.name == null ||
                            merchandiseModel.name == ""
                        ? null
                        : ListTile(
                            leading: const Text("Nome:"),
                            leadingAndTrailingTextStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            trailing: Text(merchandiseModel.name!),
                          ),
                  ),
                  ListTile(
                    leadingAndTrailingTextStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                    leading: const Text("Preço:"),
                    trailing: Text(merchandiseModel.price),
                  ),
                  ListTile(
                    leadingAndTrailingTextStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                    leading: const Text("Medidas:"),
                    trailing: Text(merchandiseModel.size),
                  ),
                  Container(
                      child: merchandiseModel.woodType != null ||
                              merchandiseModel.woodType == ""
                          ? ListTile(
                              leading: const Text("Tipo de madeira:"),
                              trailing: Text(merchandiseModel.woodType!),
                              leadingAndTrailingTextStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            )
                          : null),
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      merchandiseModel.descr ?? "",
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Publicar um produto"),
      ),
      body: WillPopScope(
        onWillPop: () async {
          _nameController.clear();
          _descrController.clear();
          _medidasController.clear();
          _priceController.clear();
          _woodtypeController.clear();
          setState(() {
            _image = null;
            _category = null;
          });

          return true;
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
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
                    color: Colors.grey.shade50,
                    surfaceTintColor: Colors.grey.shade50,
                    shadowColor: Colors.white,
                    elevation: 20,
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InputWithLabel(
                                  productName: "Nome do produto*",
                                  hintText: "Nome do Produto",
                                  controller: _nameController,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InputWithLabel(
                                  productName: "Preço*",
                                  controller: _priceController,
                                  hintText: "Ex: 15.000kz",
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Este campo é obrigatorio por favor preencha";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InputWithLabel(
                                  productName: "Medidas*",
                                  controller: _medidasController,
                                  hintText: "Ex: 1m x 5",
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Este campo é obrigatorio por favor preencha";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InputWithLabel(
                                  controller: _woodtypeController,
                                  productName: "Tipo de Madeira (Opcional)",
                                  hintText: "Ex: Musivi",
                                ),
                                const SizedBox(
                                  height: 10,
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
                  Card(
                    color: Colors.grey.shade100,
                    surfaceTintColor: Colors.grey.shade100,
                    elevation: 20,
                    shadowColor: Colors.white,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Datalhes do produto",
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InputWithLabel(
                            controller: _descrController,
                            productName: "Descrição*",
                            isExpands: false,
                            constraints:
                                const BoxConstraints.expand(height: 120),
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
                    color: Colors.grey.shade100,
                    surfaceTintColor: Colors.grey.shade100,
                    shadowColor: Colors.white,
                    elevation: 20,
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
                              // key: _formKey,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Este campo é obrigatorio por favor preencha";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorsApp.primaryTheme),
                                  )),
                              hint: const Text("Categoria"),
                              items: GlobalVariables.category.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(
                                  () {
                                    _category = value;
                                  },
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SubmitButton(
                      title: "Publicar Produto",
                      function: () async {
                        if (_formKey.currentState!.validate()) {
                          _showLoader(context);
                          if (_category != null || _image != null) {
                            MerchandiseModel merchandise = MerchandiseModel(
                              price: _priceController.text,
                              id: "",
                              hasRequest: false,
                              woodType: _woodtypeController.text,
                              size: _medidasController.text,
                              name: _nameController.text,
                              descr: _descrController.text,
                              photoUrl: "",
                            );

                            final merchandiseData =
                                await _db.setAndCreateMercadory(
                              mercadoryDoc: _category!,
                              mercadoryCollection: _category!,
                              file: _image!,
                              merchandiseModel: merchandise,
                            );

                            Navigator.pop(context);

                            _showSuccesProductDeatils(
                              context: context,
                              merchandiseModel: merchandiseData,
                            );
                            //      }
                          }
                        }
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
