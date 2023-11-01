import 'package:acg_admin/Resources/firestore_methods.dart';
import 'package:flutter/material.dart';

class MercahndiseRepository extends ChangeNotifier {
  int? totalMercahncdise;
  int? totalRequest;

  getTotalMerchandise() async {
    final result = await FirestoreMethods().sumAllMerchandise();

    totalMercahncdise = result;
    notifyListeners();
  }

  getTotalRequest() async {
    final result = await FirestoreMethods().getRequestClient();
    totalRequest = result.length;
    notifyListeners();
  }
}
