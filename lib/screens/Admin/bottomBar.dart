import 'package:acg_admin/utilis/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

   int _currentPage =0;

  _navigateToPage(int index){
    setState(() {

      _currentPage = index;

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlobalVariables.items[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
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
