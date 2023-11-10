import 'package:acg_admin/main.dart';
import 'package:acg_admin/utilis/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utilis/colors.dart';

class BottomBar extends ConsumerStatefulWidget {
  const BottomBar({super.key});

  @override
  ConsumerState<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
  int _currentPage = 0;

  _navigateToPage(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  _initGetAllSum() async {
    await ref.read(merchandiseProvider).getTotalMerchandise();
  }

  _initGetAllRequest() async {
    final requestRef = ref.read(requestProvider);
    await requestRef.getTotalRquest();
    await requestRef.getSumRequest();
  }

  _initGetAllProductSell() async {
    final productSellRef = ref.read(productSellProvider);

    productSellRef.getSizeProductSell();
  }

  @override
  void initState() {
    _initGetAllSum();
    _initGetAllRequest();
    _initGetAllProductSell();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlobalVariables.items[_currentPage],
      bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.grey.shade100,
          /* selectedItemColor: ColorsApp.primaryTheme,
          onTap: _navigateToPage,
          iconSize: 30,
          unselectedItemColor: Colors.grey.shade600, */
          surfaceTintColor: Colors.grey.shade100,
          shadowColor: Colors.grey.shade100,
          onDestinationSelected: _navigateToPage,
          indicatorColor: ColorsApp.primaryTheme,
          elevation: 20,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          indicatorShape:
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(15)),
          destinations: [
            InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () => _navigateToPage(0),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: _currentPage != 0
                      ? null
                      : Border(
                          top: BorderSide(
                              color: ColorsApp.primaryTheme, width: 2),
                        ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      CupertinoIcons.waveform_path_ecg,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Status",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () => _navigateToPage(1),
              child: Container(
                decoration: BoxDecoration(
                  border: _currentPage != 1
                      ? null
                      : Border(
                          top: BorderSide(
                              color: ColorsApp.primaryTheme, width: 2),
                        ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.admin_panel_settings,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Admin",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ),

            /*  NavigationBar(
              label: "Status",
              icon: Icon(
                CupertinoIcons.waveform_path_ecg,
              ),
            ), */
            /*    BottomNavigationBarItem(
              label: "Solicitações",
              icon: Icon(
                Icons.shopping_cart_checkout,
              ),
            )/* , */
            BottomNavigationBarItem(
              label: "Admin",
              icon: Icon(
                Icons.admin_panel_settings,
              ),
            ), */
          ]),
    );
  }
}
