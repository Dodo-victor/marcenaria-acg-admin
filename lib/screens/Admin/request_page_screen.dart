import 'package:acg_admin/Resources/firestore_methods.dart';
import 'package:acg_admin/models/merchandise_model.dart';
import 'package:acg_admin/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'request_details_screen.dart';

class RequestPageScreen extends ConsumerWidget {
  RequestPageScreen({Key? key}) : super(key: key);
  final requuestProvider = FutureProvider<List>((ref) async {
    final requestData = await FirestoreMethods().getRequestClient();

    return requestData;
    
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestData = ref.watch(requuestProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Solicitações'),
        ),
        body: requestData.when(data: (data) {
          // print(data.first["nome"]);
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Solicitação",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Aqui estrão todas as solicitaçoes dos seus clientes",
                  style: TextStyle(fontSize: 15, color: Colors.black45),
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final merchandiseData = data[index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              final MerchandiseModel merchandiseModel =
                                  MerchandiseModel.fromMap(merchandiseData);
                              return RequestDetaiScreen(
                                merchandiseModel: merchandiseModel,
                              );
                            }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          merchandiseData["foto"],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(merchandiseData["nome"]),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      /*      Text(merchandiseData["preço"]),
                                      SizedBox(
                                        height: 5,
                                      ), */
                                      Text("11/8/2015")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
        }, error: (error, stackTrace) {
          return const Center(
            child: Text("Oorreu um erro por favor tente mais tarde! "),
          );
        }, loading: () {
          return const Center(
            child: Loader(),
          );
        }));
  }
}
