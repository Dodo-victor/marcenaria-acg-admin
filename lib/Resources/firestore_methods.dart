// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:acg_admin/Resources/storage_methods.dart';
import 'package:acg_admin/utilis/showSnackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/merchandise_model.dart';

class FirestoreMethods {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final StorageMethods _storage = StorageMethods();

  setAndCreateMercadory(
      {required String mercadoryDoc,
      required String mercadoryCollection,
      required Uint8List file,
      required MerchandiseModel merchandiseModel}) async {
    final uid = const Uuid().v4();

    final photoUrl = await _storage.saveProductImage(
        childName: "productImages", file: file, productId: uid);

    final MerchandiseModel pruduct = MerchandiseModel(
      price: merchandiseModel.price,
      name: merchandiseModel.name,
      descr: merchandiseModel.descr,
      photoUrl: photoUrl,
      id: uid,
      //   hasRequest: false,
      size: merchandiseModel.size,
      woodType: merchandiseModel.woodType,
    );

    await db
        .collection("marçenaria")
        .doc(mercadoryDoc)
        .collection(mercadoryCollection)
        .doc(uid)
        .set(
          pruduct.toMap(),
        );

    final merchandiseData = await db
        .collection("marçenaria")
        .doc(mercadoryDoc)
        .collection(mercadoryCollection)
        .where("id", isEqualTo: uid)
        .get();

    if (merchandiseData.size != 0) {
      //  print(merchandiseData.docs[0]);

      MerchandiseModel merchandiseModel =
          MerchandiseModel.fromMap(merchandiseData.docs[0]);

      return merchandiseModel;
    }
  }

  sumAllMerchandise() async {
    final doorData = await db
        .collection('marçenaria')
        .doc("Portas")
        .collection("Portas")
        .get();
    final doorSize = doorData.size;

    final windowData = await db
        .collection('marçenaria')
        .doc("Janelas")
        .collection("Janelas")
        .get();
    final windowSize = windowData.size;
    final tableData = await db
        .collection('marçenaria')
        .doc("Mesas")
        .collection("Mesas")
        .get();
    final tableSize = tableData.size;

    final cabinetData = await db
        .collection('marçenaria')
        .doc("Armarios")
        .collection("Armarios")
        .get();
    final cabinetSize = cabinetData.size;
    final bedData = await db
        .collection('marçenaria')
        .doc("Camas")
        .collection("Camas")
        .get();

    final bedSize = bedData.size;

    final chairData = await db
        .collection('marçenaria')
        .doc("Cadeiras")
        .collection("Cadeiras")
        .get();

    final chairSize = chairData.size;

    final pulpitData = await db
        .collection('marçenaria')
        .doc("Pulpitos")
        .collection("Pulpitos")
        .get();

    final pulpitSize = pulpitData.size;

    final rankData = await db
        .collection('marçenaria')
        .doc("Ranks")
        .collection("Ranks")
        .get();

    final rankSize = rankData.size;

    final int totalMerchandise = doorSize +
        pulpitSize +
        chairSize +
        bedSize +
        tableSize +
        cabinetSize +
        windowSize +
        rankSize;

    /*   int totalCabinet,
        int totalDoor,
        int totalChair,
        int totalwindow,
        int totalPulpit,
        int totalTable,
        int totalRanks,
        int totalBed,
        int totalMercahncdise */

    return (
      totalCabinet: cabinetSize,
      totalDoor: doorSize,
      totalChair: chairSize,
      totalPulpit: pulpitSize,
      totalWindow: windowSize,
      totalTable: tableSize,
      totalRanks: rankSize,
      totalBed: bedSize,
      totalMerchandise: totalMerchandise,
    );
  }

  Future<List<dynamic>> getRequestClient() async {
    final data = await db.collection('usuários').get();

    List requestList = [];

    List<String> uids = [
      "JWZBLIUWLmMDGIkjv5RlCAjyJqy2",
      "OAu445Tj64h3ntJDiIXyp1zKCF32",
      "P0z4QjnJ0vVBhIeF8E94Khpp2Rn1"
    ];
    for (var element in uids) {
      final requestdata = await db
          .collection("solicitação")
          .doc(element)
          .collection("solicitação")
          .get();
      for (var element in requestdata.docs) {
        requestList.add(element);
      }
    }

    return requestList;
  }

  getMerchandiseData(
      {required String merchandiseDoc, required String merchandiseCollection}) {
    return db
        .collection('marçenaria')
        .doc(merchandiseDoc)
        .collection(merchandiseCollection)
        .get();
  }

  updateMerchandiseData(BuildContext context,
      {required String merchandiseDoc,
      required merchandiseCollection,
      required productId,
      required Map<Object, Object?> data}) async {
    try {
      await db
          .collection('marçenaria')
          .doc(merchandiseDoc)
          .collection(merchandiseCollection)
          .doc(productId)
          .update(data);
    } catch (e) {
      showSnackBar(content: "Ocorreu um erro desconhecido", context: context);
    }
  }
}
