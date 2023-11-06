import 'package:acg_admin/Resources/firestore_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductSellRepository extends ChangeNotifier {
  int? _totalSize;

  int? get totalSize => _totalSize;

  getSizeProductSell() async {
    final productSellData = await FirestoreMethods().getProductSell();

    _totalSize = productSellData.totalProducSell;

    notifyListeners();
  }

  refreshProductSellData() async {
    await FirebaseFirestore.instance.collection("vendas").get();

    await getSizeProductSell();
    notifyListeners();
  }
}
