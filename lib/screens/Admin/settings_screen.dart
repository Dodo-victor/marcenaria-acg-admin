import 'package:acg_admin/Resources/firestore_methods.dart';
import 'package:acg_admin/utilis/showSnackBar.dart';
import 'package:acg_admin/utilis/show_product_sell_sucess.dart';
import 'package:acg_admin/widgets/editting_field.dart';
import 'package:acg_admin/widgets/loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_input.dart';
import '../../widgets/submit_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

bool _isAdding = false;
bool _isEditingContact = true;

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _contactController = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  /* Widget adidinContactVerification() {
    if (_isAdding) {
      return Row(
        children: [
          const EdittingField(),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {},
            child: const Text(
              "X",
              style: TextStyle(
                fontSize: 17,
                color: Colors.black45,
              ),
            ),
          )
        ],
      );
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conctactos"),
      ),
      // extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Adiciona novas formas de contacto",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Clica no botão abaixo para adicionar um número de telefone",
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(),
              const SizedBox(
                height: 8,
              ),
              StreamBuilder<dynamic>(
                  stream: FirestoreMethods().getAllContacts(),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const Loader();
                    }

                    if (snap.hasData) {
                      final snapData = snap.data;
                      final length = snapData.docs.length;
                      print(length);
                      return snapData.docs.isEmpty
                          ? Column(
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                _isAdding
                                    ? InkWell(
                                        onTap: () {
                                          setState(() {
                                            _isAdding = !_isAdding;
                                          });
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              border: Border.all(),
                                            ),
                                            child: const Icon(Icons.add_sharp)),
                                      )
                                    : SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Form(
                                              key: _formState,
                                              child: CustomInput(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Este campo não pode estar vázio";
                                                  }

                                                  return null;
                                                },
                                                title: "insira o contacto",
                                                controller: _contactController,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SubmitButton(
                                                function: () {
                                                  if (_formState.currentState!
                                                      .validate()) {
                                                    FirestoreMethods()
                                                        .settingsRemote(
                                                            phoneMumber:
                                                                _contactController
                                                                    .text,
                                                            context: context);
                                                    _contactController.clear();
                                                    showSnackBar(
                                                        content:
                                                            "Contacto adicionado!",
                                                        context: context);
                                                  }
                                                },
                                                title: "Adcionar"),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            SubmitButton(
                                              title: "Cancelar",
                                              color: Colors.red,
                                              width: 200,
                                              function: () {
                                                _contactController.clear();
                                                setState(() {
                                                  _isAdding = false;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                              ],
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: 400,
                                  child: ListView.builder(
                                      itemCount: length,
                                      itemBuilder: (context, index) {
                                        final contactData =
                                            snapData.docs[index];
                                        return InkWell(
                                          onLongPress: () async {
                                            await FirebaseFirestore.instance
                                                .collection("definições")
                                                .doc("contactos")
                                                .collection("contacto")
                                                .doc(contactData["id"])
                                                .delete();
                                            showSnackBar(
                                                content: "Contacto apagado",
                                                context: context);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 5),
                                            color: Colors.grey.shade300,
                                            child: Text(
                                                "+244 ${contactData["numeroDeTelefone"]}"),
                                          ),
                                        );
                                      }),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                _isAdding
                                    ? SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Form(
                                              key: _formState,
                                              child: CustomInput(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Este campo não pode estar vázio";
                                                  }

                                                  return null;
                                                },
                                                title: "insira o contacto",
                                                controller: _contactController,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SubmitButton(
                                                function: () {
                                                  if (_formState.currentState!
                                                      .validate()) {
                                                    FirestoreMethods()
                                                        .settingsRemote(
                                                            phoneMumber:
                                                                _contactController
                                                                    .text,
                                                            context: context);
                                                    _contactController.clear();
                                                    showSnackBar(
                                                        content:
                                                            "Contacto adicionado!",
                                                        context: context);
                                                  }
                                                },
                                                title: "Adcionar"),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            SubmitButton(
                                              title: "Cancelar",
                                              color: Colors.red,
                                              width: 200,
                                              function: () {
                                                _contactController.clear();
                                                setState(() {
                                                  _isAdding = false;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          setState(() {
                                            _isAdding = true;
                                          });
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              border: Border.all(),
                                            ),
                                            child: const Icon(Icons.add_sharp)),
                                      ),
                              ],
                            );
                    }

                    return const Center(
                      child: Text("Ocorreu um erro desconhecido"),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
