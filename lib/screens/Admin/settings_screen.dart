import 'package:acg_admin/Resources/firestore_methods.dart';
import 'package:acg_admin/utilis/show_product_sell_sucess.dart';
import 'package:acg_admin/widgets/editting_field.dart';
import 'package:acg_admin/widgets/loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

bool _isAdding = false;
bool _isEditingContact = true;

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
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection("definições")
                  .doc("contactos")
                  .collection("contacto")
                  .doc("66fed780-7d83-4a9e-bc93-92cfb1edc7be")
                  .delete();
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      // extendBodyBehindAppBar: true,
      body: Padding(
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
                              _isAdding
                                  ? EdittingField(
                                      isEditingName: _isEditingContact,
                                      isEditting: _isEditingContact,
                                      isEdittingFunc: () {
                                        setState(() {
                                          _isEditingContact =
                                              !_isEditingContact;
                                        });
                                      },
                                      updateData: () async {
                                        setState(() {
                                          _isEditingContact = true;
                                        });

                                        await FirestoreMethods().settingsRemote(
                                            phoneMumber:
                                                _contactController.text,
                                            context: context);

                                        setState(() {
                                          _isEditingContact = false;
                                          _isAdding = false;
                                        });
                                      },
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
                          )
                        : Expanded(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 400,
                                  child: ListView.builder(
                                      itemCount: length,
                                      itemBuilder: (context, index) {
                                        final contactData =
                                            snapData.docs[index];
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          color: Colors.grey.shade300,
                                          child: InkWell(
                                            onLongPress: () async {
                                              await FirebaseFirestore.instance
                                                  .collection("definições")
                                                  .doc("contactos")
                                                  .collection("contacto")
                                                  .doc(contactData["id"])
                                                  .delete();

                                              print("press");
                                            },
                                            child: TextFormField(
                                              onTap: () {},
                                              readOnly: true,
                                              initialValue: contactData[
                                                  "numeroDeTelefone"],
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                _isAdding
                                    ? EdittingField(
                                        isEditingName: _isEditingContact,
                                        isEditting: false,
                                        loader: false,
                                        isEdittingFunc: () {
                                          setState(() {
                                            _isEditingContact =
                                                !_isEditingContact;
                                          });
                                        },
                                        updateData: () async {
                                          setState(() {
                                            _isEditingContact = true;
                                          });

                                          await FirestoreMethods()
                                              .settingsRemote(
                                                  phoneMumber:
                                                      _contactController.text,
                                                  context: context);

                                          setState(() {
                                            _isEditingContact =
                                                !_isEditingContact;
                                            _isAdding = !_isAdding;
                                          });
                                        },
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
                            ),
                          );
                  }

                  return const Center(
                    child: Text("Ocorreu um erro desconhecido"),
                  );
                })
          ],
        ),
      ),
    );
  }
}
