import 'package:acg_admin/main.dart';
import 'package:acg_admin/screens/Admin/add_merchandise_screen.dart';
import 'package:acg_admin/screens/Admin/request_status_screnn.dart';
import 'package:acg_admin/screens/Admin/show_merchandise_screen.dart';
import 'package:acg_admin/utilis/colors.dart';
import 'package:acg_admin/utilis/global_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Olá ${FirebaseAuth.instance.currentUser!.displayName}",
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddMerchandiseScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.edit_note,
                size: 35,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Consumer(builder: (context, WidgetRef ref, child) {
            final refData = ref;
            final merchandiseData = refData.watch(merchandiseProvider);
            final requestData = refData.watch(requestProvider);
            final productSellData = refData.watch(productSellProvider);
            return RefreshIndicator(
              color: ColorsApp.primaryTheme,
              onRefresh: () async {
               GlobalVariables.category.map((e) async {
               return  merchandiseData.refreshProductData(merchandiseDoc: e, merchandiseCollection: e);
               });

              
                await requestData.getTotalRquest();

                await productSellData.refreshProductSellData();
              },
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      const Text("Relatório Geral",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 8,
                      ),
                      FittedBox(
                        child: merchandiseData.totalMercahncdise != null &&
                                requestData.totalRequest != null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ShowMerchandiseScreen(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 120,
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                          //  border: Border(right: BorderSide( : Colors.grey)),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: ColorsApp.googleSignInColor),
                                      child: Column(
                                        children: [
                                          Text(
                                            merchandiseData.totalMercahncdise
                                                    .toString() ??
                                                "350",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Mercadoria",
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const RequestStatusScrenn()));
                                    },
                                    child: Container(
                                      width: 120,
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: ColorsApp.googleSignInColor,
                                        borderRadius: BorderRadius.circular(10),
                                        //border: Border(right: BorderSide(color: Colors.grey),),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            requestData.totalRequest.toString(),
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            "Solicitações",
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 120,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: ColorsApp.googleSignInColor,
                                      borderRadius: BorderRadius.circular(10),
                                      //border: Border(right: BorderSide(color: Colors.grey),),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          productSellData.totalSize.toString(),
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Vendas",
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              )
                            : FittedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (int i = 0; i < 3; i++)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 80,
                                          width: 120,
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: ColorsApp.googleSignInColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            //border: Border(right: BorderSide(color: Colors.grey),),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                      )
                    ],
                  ),
                ],
              ),
            );
          }),
        ) /* Center(
        child: InkWell(
          onTap: () async {
            await FirebaseAuth.instance.signOut();
          },
          child: Text("Sair"),
        ),
      ), */
        );
  }
}
