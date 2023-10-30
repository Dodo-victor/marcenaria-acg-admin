import 'package:acg_admin/Resources/firestore_methods.dart';
import 'package:acg_admin/models/merchandise_model.dart';
import 'package:acg_admin/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestPageScreen extends ConsumerWidget {
  RequestPageScreen({Key? key}) : super(key: key);
  final requuestProvider = FutureProvider((ref) async {
    final requestData = await FirestoreMethods().getRequestClient();

    List<MerchandiseModel> merchandiseList = [];

    for (var element in requestData) {
      final MerchandiseModel merchandiseData =
          MerchandiseModel.fromMap(requestData);

      merchandiseList.add(merchandiseData);
    }

    return merchandiseList;
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _requestData = ref.watch(requuestProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Solicitações'),
        ),
        body: _requestData.when(data: (data) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
              const  Text(
                  "Solicitação",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Aqui estrão todas as solicitaçoes dos seus clientes",
                  style: TextStyle(fontSize: 15, color: Colors.black45),
                ),
                const Divider(),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final merchandiseData = data[index];

                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(10))),
                          child:  Row(
                            children: [
                             const CircleAvatar(),
                             const  SizedBox(
                                width: 8,
                              ),
                              Column(
                                children: [
                                  Text(merchandiseData.name!),
                                  const SizedBox(height: 5),
                                  Text(merchandiseData.price),
                                ],
                              ),
                            ],
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
