import 'package:acg_admin/Resources/firestore_methods.dart';
import 'package:acg_admin/Resources/times_ago_methods..dart';
import 'package:acg_admin/main.dart';
import 'package:acg_admin/models/merchandise_model.dart';
import 'package:acg_admin/screens/Admin/request_details_screen.dart';
import 'package:acg_admin/utilis/colors.dart';
import 'package:acg_admin/utilis/global_variables.dart';
import 'package:acg_admin/widgets/loader.dart';
import 'package:acg_admin/widgets/request_status_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestStatusScrenn extends ConsumerStatefulWidget {
  const RequestStatusScrenn({Key? key}) : super(key: key);

  @override
  RequestStatusScrennState createState() => RequestStatusScrennState();
}

class RequestStatusScrennState extends ConsumerState<RequestStatusScrenn>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 8, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final requestData = ref.watch(requestProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Solicitações"),
        bottom: TabBar(
          isScrollable: true,
          indicatorColor: ColorsApp.primaryTheme.withOpacity(0.5),
          indicator: BoxDecoration(
              color: ColorsApp.googleSignInColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10)),
          labelPadding: const EdgeInsets.all(10),
          //padding: const EdgeInsets.all(10),
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,

          tabs: [
            Text("Porta (${requestData.requestDoorSize})"),
            Text("Janela (${requestData.requestWindowSize})"),
            Text("Mesa (${requestData.requestBedSize})"),
            Text("Rank (${requestData.rankSize})"),
            Text("Pulpito (${requestData.requestPulpitSize})"),
            Text("Cadeira (${requestData.requestChairSize})"),
            Text("Armário (${requestData.requestCabinetSize})"),
            Text("Camas (${requestData.requestBedSize})"),
          ],
        ),
      ),
      body: TabBarView(
          controller: _tabController,
          children: GlobalVariables.category.map((e) {
            return FutureBuilder(
              future: FirestoreMethods().getRequestData(category: e),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Loader(),
                  );
                }

                if (snap.hasData) {
                  final snapData = snap.data;
                  return snapData!.isEmpty
                      ? RefreshIndicator(
                          color: ColorsApp.primaryTheme,
                          onRefresh: () async {
                            await requestData.getSumRequest();
                          },
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: ListView(
                              children: [
                                SizedBox(
                                  height: 260,
                                ),
                                Center(
                                  child: Text(
                                    "0 Solicitações",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(color: Colors.black45),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            Expanded(
                              child: RefreshIndicator(
                                color: ColorsApp.primaryTheme,
                                onRefresh: () async {
                                  await requestData.getSumRequest();
                                  await requestData.getTotalRquest();
                                },
                                child: ListView.separated(
                                  itemCount: snapData!.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider();
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final requestData = snapData[index];

                                    final MerchandiseModel merchandise =
                                        MerchandiseModel.fromMap(requestData);

                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  RequestDetaiScreen(
                                                merchandiseModel: merchandise,
                                                userUid:
                                                    requestData["idUsuario"],
                                              ),
                                            ));
                                      },
                                      child: RequestStatusCard(
                                        clientName: merchandise.name!,
                                        price: merchandise.price,
                                        productName: merchandise.productName,
                                        date: TimesAgo.setDate(
                                          merchandise.date.toDate(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                }

                return const Center(
                  child: Text(
                    "Ocorreu um erro ao buscar os dados",
                    textAlign: TextAlign.center,
                  ),
                );
              },
            );
          }).toList()),
    );
  }
}
