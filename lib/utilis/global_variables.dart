import 'package:acg_admin/screens/Admin/home_screen.dart';
import 'package:acg_admin/screens/Admin/admin_dasboard.dart';
import 'package:acg_admin/screens/Admin/request_page_screen.dart';
import 'package:flutter/material.dart';

class GlobalVariables {
  static final List<Widget> items = [
    const HomeScreen(),
    // RequestPageScreen(),
    const AdminDashboard()
  ];

  static greetings() {
    final currentDate = DateTime.now();

    if (currentDate.hour >= 18) {
      return "Boa noite";
    } else if (currentDate.hour < 12) {
      return "Bom dia";
    } else if (currentDate.hour >= 12) {
      return "Boa tarde";
    }
  }

  static final List<String> category = [
    "Portas",
    "Janelas",
    "Mesas",
    "Ranks",
    "Pulpitos",
    "Cadeiras",
    "Armários",
    "Camas",
  ];
}
