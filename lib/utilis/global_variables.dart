import 'package:acg_admin/screens/Admin/home_screen.dart';
import 'package:acg_admin/screens/Admin/profile_screen.dart';
import 'package:acg_admin/screens/Admin/request_page_screen.dart';
import 'package:flutter/material.dart';

class GlobalVariables {
  static final List<Widget> items = [
    const HomeScreen(),
     RequestPageScreen(),
    const ProfileScreen(),
  ];

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
