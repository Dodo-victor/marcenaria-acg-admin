import 'package:acg_admin/Resources/firestore_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/merchandise_model.dart';

class MercahndiseRepository extends ChangeNotifier {
  int? _totalMerchandise;
  int? _totalRequest;
  int? _doorSize;
  int? _windowSize;
  int? _pulpitSize;
  int? _rankSize;
  int? _chairSize;
  int? _bedSize;
  int? _cabinetSize;
  int? _tableSize;
  MerchandiseModel? _merchandiseModel;
/*   String? _productName;
  String? _price; */

  int? get totalMercahncdise => _totalMerchandise;
  int? get totalRequest => _totalRequest;
  int get doorSize => _doorSize ?? 0;
  int get windowSize => _windowSize ?? 0;
  int get pulpitSize => _pulpitSize ?? 0;
  int get rankSize => _rankSize ?? 0;
  int get chairSize => _chairSize ?? 0;
  int get bedSize => _bedSize ?? 0;
  int get cabinetSize => _cabinetSize ?? 0;
  int get tableSize => _tableSize ?? 0;
  MerchandiseModel? get merchandiseModel => _merchandiseModel;

/*   String? get productName => _productName;
  String get price => _price ?? ""; */

  getTotalMerchandise() async {
    final result = await FirestoreMethods().sumAllMerchandise();

    _totalMerchandise = result.totalMerchandise;
    _doorSize = result.totalDoor;
    _chairSize = result.totalChair;
    _cabinetSize = result.totalCabinet;
    _pulpitSize = result.totalPulpit;
    _rankSize = result.totalRanks;
    _tableSize = result.totalTable;
    _bedSize = result.totalBed;
    _windowSize = result.totalWindow;

    notifyListeners();
  }

  getTotalRequest() async {
    final result = await FirestoreMethods().getRequestClient();
    _totalRequest = result.length;
    notifyListeners();
  }

  getProductData(
      {required String merchandiseDoc,
      required merchandiseCollection,
      required productId}) async {
    final productData = await FirebaseFirestore.instance
        .collection('marçenaria')
        .doc(merchandiseDoc)
        .collection(merchandiseCollection)
        .doc(productId)
        .get();

    final MerchandiseModel merchandiseData =
        MerchandiseModel.fromMap(productData);

    _merchandiseModel = merchandiseData;

    /*  _productName = merchandiseData.name ?? "";
    _price = merchandiseData.price; */

    notifyListeners();
  }
}
