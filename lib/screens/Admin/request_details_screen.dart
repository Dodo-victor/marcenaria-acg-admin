import 'package:acg_admin/models/merchandise_model.dart';
import 'package:acg_admin/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class RequestDetaiScreen extends StatelessWidget {
  final MerchandiseModel merchandiseModel;
  const RequestDetaiScreen({super.key, required this.merchandiseModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius:
                      const BorderRadius.only(bottomRight: Radius.circular(15)),
                ),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(15)),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(merchandiseModel.photoUrl)),

                    //color: Colors.gr
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                leading: const Text(
                  "Solicitante",
                  style: TextStyle(fontSize: 17),
                ),
                trailing: Text(
                  merchandiseModel.name ?? "Victor Manuel",
                  style: const TextStyle(fontSize: 17),
                ),
              ),
              ListTile(
                leading: const Text(
                  "Preço",
                  style: TextStyle(fontSize: 17),
                ),
                trailing: Text(
                  merchandiseModel.price,
                  style: const TextStyle(fontSize: 17),
                ),
              ),
              const ListTile(
                leading: Text(
                  "Telefone",
                  style: TextStyle(fontSize: 17),
                ),
                trailing: Text(
                  "921750554",
                  style: TextStyle(fontSize: 17),
                ),
              ),
              const ListTile(
                leading: Text(
                  "Email",
                  style: TextStyle(fontSize: 17),
                ),
                trailing: Text(
                  "wondersteip@gmail.com",
                  style: TextStyle(fontSize: 17),
                ),
              ),
              const ListTile(
                leading: Text(
                  "Categoria",
                  style: TextStyle(fontSize: 17),
                ),
                trailing: Text(
                  "Portas",
                  style: TextStyle(fontSize: 17),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(),
              const SizedBox(
                height: 5,
              ),
              const SubmitButton(
                title: "Marcar como vendido",
                color: Colors.greenAccent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
