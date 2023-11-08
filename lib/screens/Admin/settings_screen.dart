import 'package:acg_admin/Resources/firestore_methods.dart';
import 'package:acg_admin/main.dart';
import 'package:acg_admin/widgets/editting_field.dart';
import 'package:acg_admin/widgets/loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

bool _isAdding = false;
bool _isEditingContact = false;

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _contactController = TextEditingController();

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
      body: Consumer(builder: (context, WidgetRef ref, child) {
        final conatactProv = ref.watch(addContactProvider);
        return Padding(
          padding: const EdgeInsets.all(15.0),
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
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isAdding = false;
                                    });
                                  },
                                  child: const Text(
                                    "X",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black45,
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Expanded(
                              child: SizedBox(
                                child: ListView.builder(
                                    itemCount: length,
                                    itemBuilder: (context, index) {
                                      final contactData = snapData.docs[index];
                                      return Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 120,
                                                child: EdittingField(
                                                  controller:
                                                      _contactController,
                                                  isEdittingFunc: () async {
                                                    final _contact = {
                                                      "numeroDeTelefone":
                                                          _contactController
                                                              .text
                                                    };

                                                    await FirestoreMethods()
                                                        .settingsRemote(
                                                            settingsType:
                                                                "contactos",
                                                            data: _contact,
                                                            context: context);
                                                  },
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _isAdding = false;
                                                  });
                                                },
                                                child: const Text(
                                                  "X",
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black45,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          _isAdding
                                              ? EdittingField(
                                                  isEdittingFunc: () {
                                                    conatactProv
                                                        .isEditingFunc();
                                                  },


                                                  updateData: () async {
                                                    setState(() {
                                                      _isEditingContact = true;
                                                    });
                                                    await FirestoreMethods()
                                                        .settingsRemote(
                                                        settingsType:
                                                        "contactos",
                                                        data: {
                                                          "numeroDeTelefone":
                                                          _contactController
                                                              .text
                                                        },
                                                        context: context);

                                                    setState(() {
                                                      _isEditingContact = false;
                                                    });
                                                  },

                                                  isEditingName: conatactProv
                                                      .isEditingContact,
                                            isEditting: _isEditingContact,
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      _isAdding = true;
                                                    });
                                                  },
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(),
                                                      ),
                                                      child: const Icon(
                                                          Icons.add_sharp)),
                                                ),
                                        ],
                                      );
                                    }),
                              ),
                            );
                    }

                    return const Center(
                      child: Text("Ocorreu um erro desconhecido"),
                    );
                  }),
            ],
          ),
        );
      }),
    );
  }
}
