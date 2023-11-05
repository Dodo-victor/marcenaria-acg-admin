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

  @override
  void initState() {
    _initGetAllSum();
    _initGetAllRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlobalVariables.items[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: ColorsApp.primaryTheme,
          onTap: _navigateToPage,
          currentIndex: _currentPage,
          items: const [
            BottomNavigationBarItem(
              label: "Status",
              icon: Icon(
                CupertinoIcons.waveform_path_ecg,
              ),
            ),
            BottomNavigationBarItem(
              label: "Solicitações",
              icon: Icon(
                Icons.shopping_cart_checkout,
              ),
            ),
            BottomNavigationBarItem(
              label: "Perfil",
              icon: Icon(
                Icons.settings,
              ),
            ),
          ]),
    );
  }
}
