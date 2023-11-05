import 'dart:ffi';

import 'package:acg_admin/Resources/firestore_methods.dart';
import 'package:flutter/material.dart';

class RequestRepository extends ChangeNotifier {
  int? _totalMerchandise;
  int? _totalRequest;
  int? _requestDoorSize;
  int? _requestwindowSize;
  int? _requestPulpitSize;
  int? _requestRankSize;
  int? _requestChairSize;
  int? _requestBedSize;
  int? _requestCabinetSize;
  int? _requestTableSize;

  int? get totalMercahncdise => _totalMerchandise;
  int? get totalRequest => _totalRequest ?? 0;
  int get requestDoorSize => _requestDoorSize ?? 0;
  int get requestWindowSize => _requestwindowSize ?? 0;
  int get requestPulpitSize => _requestPulpitSize ?? 0;
  int get rankSize => _requestRankSize ?? 0;
  int get requestChairSize => _requestChairSize ?? 0;
  int get requestBedSize => _requestBedSize ?? 0;
  int get requestCabinetSize => _requestCabinetSize ?? 0;
  int get requestTableSize => _requestTableSize ?? 0;

  getSumRequest() async {
    final requestData = await FirestoreMethods().getTotalRequest();

    _requestDoorSize =
        await requestData.elementAt(0).then((value) => value.length);
    _requestwindowSize =
        await requestData.elementAt(1).then((value) => value.length);

    _requestTableSize =
        await requestData.elementAt(2).then((value) => value.length);

    _requestRankSize =
        await requestData.elementAt(3).then((value) => value.length);

    _requestPulpitSize =
        await requestData.elementAt(4).then((value) => value.length);

    _requestChairSize =
        await requestData.elementAt(5).then((value) => value.length);

    _requestCabinetSize =
        await requestData.elementAt(6).then((value) => value.length);

    _requestBedSize =
        await requestData.elementAt(7).then((value) => value.length);

    notifyListeners();
  }

  getTotalRquest() async {
    final result = await FirestoreMethods().getRequestClient();
    _totalRequest = result.length;
    notifyListeners();
  }
}
