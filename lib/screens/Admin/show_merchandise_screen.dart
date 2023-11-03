import 'package:acg_admin/Resources/times_ago_methods..dart';
import 'package:acg_admin/main.dart';
import 'package:acg_admin/models/merchandise_model.dart';
import 'package:acg_admin/screens/Admin/merchandise_details_screen.dart';
import 'package:acg_admin/utilis/global_variables.dart';
import 'package:acg_admin/widgets/loader.dart';
import 'package:acg_admin/widgets/mercadory_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Resources/firestore_methods.dart';
import '../../utilis/colors.dart';

class ShowMerchandiseScreen extends ConsumerStatefulWidget {
  const ShowMerchandiseScreen({Key? key}) : super(key: key);

  @override
  ShowMerchandiseScreenState createState() => ShowMerchandiseScreenState();
}

class ShowMerchandiseScreenState extends ConsumerState<ShowMerchandiseScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 8, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final merchandiseData = ref.watch(merchandiseProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mercadorias"),
        bottom: TabBar(
          isScrollable: true,
          dividerColor: ColorsApp.googleSignInColor,
          tabs: [
            Text("Porta (${merchandiseData.doorSize})"),
            Text("Janela (${merchandiseData.windowSize})"),
            Text("Mesa (${merchandiseData.tableSize})"),
            Text("Rank (${merchandiseData.rankSize})"),
            Text("Pulpito (${merchandiseData.pulpitSize})"),
            Text("Cadeira (${merchandiseData.chairSize})"),
            Text("Armário (${merchandiseData.cabinetSize})"),
            Text("Camas (${merchandiseData.bedSize})"),
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
      body: TabBarView(
          controller: _tabController,
          children: GlobalVariables.category.map((e) {
            return FutureBuilder<dynamic>(
                future: FirestoreMethods().getMerchandiseData(
                    merchandiseDoc: e, merchandiseCollection: e),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Loader(),
                    );
                  }

                  if (snap.hasData) {
                    final length = snap.data.docs.length as dynamic;

                    if (length == 0) {
                      return RefreshIndicator(
                        color: ColorsApp.primaryTheme,
                        onRefresh: () async {
                          await merchandiseData.refreshProductData(
                            merchandiseDoc: e,
                            merchandiseCollection: e,
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: ListView.builder(
                                  itemCount: 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 260,
                                        ),
                                        Text(
                                          "Sem Registro",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.copyWith(color: Colors.black45),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return RefreshIndicator(
                        color: ColorsApp.primaryTheme,
                        onRefresh: () async {
                          await merchandiseData.refreshProductData(
                            merchandiseDoc: e,
                            merchandiseCollection: e,
                          );
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                itemCount: length,
                                itemBuilder: (context, index) {
                                  final merchandiseData = snap.data.docs;

                                  final MerchandiseModel merchandiseModel =
                                      MerchandiseModel.fromMap(
                                          merchandiseData[index]);

                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MerchandiseDetailsScreen(
                                            merchandiseModel: merchandiseModel,
                                            merchandiseDoc: e,
                                            merchandiseCollection: e,
                                          ),
                                        ),
                                      );
                                    },
                                    child: MerchandiseCard(
                                      productName: merchandiseModel.name ?? "",
                                      price: merchandiseModel.price,
                                      date: TimesAgo.setDate(
                                        merchandiseModel.date.toDate(),
                                      ),
                                      photoUrl: merchandiseModel.photoUrl,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 20),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  }

                  return const Center(
                    child: Text(
                      "Ocorreu um erro ao buscar os dados",
                      textAlign: TextAlign.center,
                    ),
                  );
                });
          }).toList()),
    );
  }
}
