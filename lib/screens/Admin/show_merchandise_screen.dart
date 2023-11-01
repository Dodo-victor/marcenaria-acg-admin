import 'package:acg_admin/widgets/loader.dart';
import 'package:flutter/material.dart';

import '../../Resources/firestore_methods.dart';
import '../../utilis/colors.dart';

class ShowMerchandiseScreen extends StatefulWidget {
  const ShowMerchandiseScreen({Key? key}) : super(key: key);

  @override
  ShowMerchandiseScreenState createState() => ShowMerchandiseScreenState();
}

class ShowMerchandiseScreenState extends State<ShowMerchandiseScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mercadorias"),
        bottom: TabBar(
          tabs: [
            const Text("Portas 54"),
            const Text("Janelas 45"),
          ],
          indicator: BoxDecoration(
              color: ColorsApp.googleSignInColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10)),
          labelPadding: const EdgeInsets.all(10),
          //padding: const EdgeInsets.all(10),
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          //  indicatorPadding: EdgeInsets.all(8),
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        FutureBuilder<dynamic>(
          future: FirestoreMethods().getMerchandiseData(
              merchandiseDoc: "Portas", merchandiseCollection: "Portas"),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Loader(),
              );
            }

            if (snap.hasData) {
              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: snap.data.docs.length as dynamic,
                        itemBuilder: (context, index) {
                          return FittedBox(
                            child: SizedBox(
                              height: 200,
                              width: 200,
                              child: ListTile(
                                leading: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10)),
                                      color: Colors.grey.shade200),
                                  child: Container(
                                    height: 75,
                                    width: 75,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(""),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                subtitle: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Mesa Orval"),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text("50.000.00kz"),
                                  ],
                                ),
                                trailing: const Text(
                                  "a poucos segundos 1 dia",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ); /* SizedBox(
                height: 200,
                width: 400,
                child: ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(10)),
                        color: Colors.grey.shade200),
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(""),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  subtitle: Text(
                      "DATA"), /* const Column(
                    children: [
                      Text("Mesa Orval"),
                      SizedBox(
                        height: 5,
                      ),
                      Text("50.000.00kz"),
                      SizedBox(
                        height: 5,
                      ),
                      Text("1 dia"),
                    ],
                  ), */
                ),
              ); */
            }

            return const Center(
              child: Text(
                "Ocorreu um erro ao buscar os dados",
                textAlign: TextAlign.center,
              ),
            );
          },
        ),
        FutureBuilder(
            future: FirestoreMethods().getMerchandiseData(
                merchandiseDoc: "Janelas", merchandiseCollection: "Janelas"),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Loader(),
                );
              }

              if (snap.hasData) {
                return Center(
                  child: Text("data"),
                ); /* SizedBox(
                  height: 200,
                  width: 400,
                  child: ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10)),
                          color: Colors.grey.shade200),
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(""),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    subtitle: Text("DATA"),
                  ),
                ); */
              }

              return const Center(
                child: Text(
                  "Ocorreu um erro ao buscar os dados",
                  textAlign: TextAlign.center,
                ),
              );
            }),
      ]),
    );
  }
}
