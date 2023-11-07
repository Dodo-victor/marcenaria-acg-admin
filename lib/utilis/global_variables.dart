import 'package:acg_admin/screens/Admin/home_screen.dart';
import 'package:acg_admin/screens/Admin/profile_screen.dart';
import 'package:acg_admin/screens/Admin/request_page_screen.dart';
import 'package:flutter/material.dart';

class GlobalVariables {
  static final List<Widget> items = [
    const HomeScreen(),
    // RequestPageScreen(),
    const ProfileScreen(),
  ];

  static greetings() {
    final currentDate = DateTime.now();

    if (currentDate.hour >= 18) {
      return "Boa Noite";
    } else if (currentDate.hour < 12) {
      return "Bom Dia";
    } else if (currentDate.hour >= 12) {
      return "Boa Tarde";
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
