import 'package:acg_admin/models/mark_sell_model.dart';
import 'package:acg_admin/widgets/loader.dart';
import 'package:flutter/material.dart';

import '../../Resources/firestore_methods.dart';
import '../../Resources/times_ago_methods..dart';
import '../../models/merchandise_model.dart';
import 'request_details_screen.dart';

class ShowProductSell extends StatefulWidget {
  const ShowProductSell({Key? key}) : super(key: key);

  @override
  _ShowProductSellState createState() => _ShowProductSellState();
}

class _ShowProductSellState extends State<ShowProductSell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vendas"),
      ),
      body: FutureBuilder<dynamic>(
          future: FirestoreMethods().getAllMercahndiseSell(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Loader(),
              );
            }

            if (snap.hasData) {
              final snapdata = snap.data.docs as dynamic;

              return ListView.separated(
                itemCount: snapdata.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                itemBuilder: (BuildContext context, int index) {
                  final prductSellData = snapdata[index];

                  final MarkSellProduct markSellProduct =
                      MarkSellProduct.fromMap(prductSellData);

                  final MerchandiseModel merchandiseModel =
                      MerchandiseModel.fromMap(prductSellData);

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RequestDetaiScreen(
                            merchandiseModel: merchandiseModel,
                            isSell: true,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Positioned(
                            right: 0,
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(180),
                              ),
                              child: Icon(
                                Icons.done_sharp,
                                color: Colors.grey.shade100,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  height: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey.shade400,
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                  markSellProduct
                                                      .merchandiseModel
                                                      .photoUrl),
                                            )),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              markSellProduct.merchandiseModel
                                                  .productName!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              markSellProduct
                                                  .merchandiseModel.price,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                      color: Colors.black45),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        TimesAgo.setDate(markSellProduct
                                            .merchandiseModel.date
                                            .toDate()),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(color: Colors.black45),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: Text(
                "Ocorreu um erro ao buscar os dados, por favor tente novamente mais tarde!",
                textAlign: TextAlign.center,
              ),
            );
          }),
    );
  }
}
