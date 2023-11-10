// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:acg_admin/Resources/storage_methods.dart';
import 'package:acg_admin/models/mark_sell_model.dart';
import 'package:acg_admin/utilis/global_variables.dart';
import 'package:acg_admin/utilis/showSnackBar.dart';
import 'package:acg_admin/utilis/show_product_sell_sucess.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/merchandise_model.dart';

class FirestoreMethods {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final StorageMethods _storage = StorageMethods();

  Future<({int totalProducSell})> getProductSell() async {
    final productSellData = await db.collection("vendas").get();

    final productSellSize = productSellData.size;

    return (totalProducSell: productSellSize);
  }

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
      date: DateTime.now(),
      category: merchandiseModel.category,
      //   hasRequest: false,
      size: merchandiseModel.size,
      woodType: merchandiseModel.woodType,
      productName: merchandiseModel.name ?? "",
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
        .doc("Armários")
        .collection("Armários")
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
    final userData = await db.collection('usuários').get();

    List requestList = [];

    for (var data in userData.docs) {
      final requestdata = await db
          .collection("solicitação")
          .doc(data["uid"])
          .collection("solicitação")
          .get();
      for (var element in requestdata.docs) {
        requestList.add(element);
      }
    }

    return requestList;
  }

  Future<List<dynamic>> getRequestData({required String category}) async {
    final userData = await db.collection('usuários').get();

    List requestList = [];

    for (var data in userData.docs) {
      final requestdata = await db
          .collection("solicitação")
          .doc(data["uid"])
          .collection("solicitação")
          .where("categoria", isEqualTo: category)
          .get();
      for (var element in requestdata.docs) {
        requestList.add(element);
      }
    }

    return requestList;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllUser() async {
    final userData = await db.collection('usuários').get();

    return userData;
  }

  /* Future<({String totalSize})> */
  Future<Iterable<Future<List<dynamic>>>> getTotalRequest() async {
    final userData = await getAllUser();

    final category = GlobalVariables.category.map((e) async {
      List requestList = [];
      for (var data in userData.docs) {
        final requestdata = await db
            .collection("solicitação")
            .doc(data["uid"])
            .collection("solicitação")
            .where("categoria", isEqualTo: e)
            .get();
        for (var element in requestdata.docs) {
          print(element.data());
          requestList.add(element);
        }
      }

      return requestList;
    });

    return category;
  }

  getMerchandiseData(
      {required String merchandiseDoc, required String merchandiseCollection}) {
    return db
        .collection('marçenaria')
        .doc(merchandiseDoc)
        .collection(merchandiseCollection)
        .get();
  }

  deleteMerchandise(
      {required String merchandiseDoc,
      required merchandiseCollection,
      required productId}) async {
    await db
        .collection('marçenaria')
        .doc(merchandiseDoc)
        .collection(merchandiseCollection)
        .doc(productId)
        .delete();

    final userData = await db.collection('usuários').get();

    for (var docs in userData.docs) {
      final requestdata = await db
          .collection("solicitação")
          .doc(docs["uid"])
          .collection("solicitação")
          .doc(productId)
          .delete();
    }
  }

  updateMerchandiseData(BuildContext context,
      {required String merchandiseDoc,
      required merchandiseCollection,
      required productId,
      required Map<Object, Object?> data,
      Map<Object, Object?>? requestData}) async {
    try {
      await db
          .collection('marçenaria')
          .doc(merchandiseDoc)
          .collection(merchandiseCollection)
          .doc(productId)
          .update(data);

      final userData = await db.collection('usuários').get();

      for (var docs in userData.docs) {
        final requestSize = await db
            .collection("solicitação")
            .doc(docs["uid"])
            .collection("solicitação")
            .doc(productId)
            .get();

        if (requestSize.exists) {
          await db
              .collection("solicitação")
              .doc(docs["uid"])
              .collection("solicitação")
              .doc(productId)
              .update(requestData ?? data);
        }
      }
    } catch (e) {
      showSnackBar(
          content: "Ocorreu um erro, tente novamente!", context: context);
    }
  }

  deleteRequestClient(
      {required String userId, required String productId, context}) async {
    try {
      await db
          .collection("solicitação")
          .doc(userId)
          .collection("solicitação")
          .doc(productId)
          .delete();
    } catch (e) {
      showSnackBar(
          content: "Ocorreu um erro tente novamente: $e", context: context);
    }
  }

  markProductSell(
      {required String category,
      required String productId,
      required MarkSellProduct markSellProduct,
      required String userUid,
      required context}) async {
    await deleteRequestClient(userId: userUid, productId: productId);

    final productSellData =
        await db.collection("vendas").where("id", isEqualTo: productId).get();

    if (productSellData.size != 0) {
      showProductSellSuccess(
          context: context,
          onEvent: Container(
            height: 65,
            width: 65,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              Icons.done,
              color: Colors.grey.shade100,
              size: 35,
            ),
          ),
          title: "Ups!",
          content: "Já marcou este produto como vendido.");
    } else {
      await db.collection("vendas").doc(productId).set(markSellProduct.toMap());
      showProductSellSuccess(context: context);
    }
  }

  settingsRemote({
    String? settingsType,
    Map<String, dynamic>? data,
    String? phoneMumber,
    required context,
  }) async {
    try {
      final id = const Uuid().v4();
      final contact = {"numeroDeTelefone": phoneMumber, "id": id};
      await db
          .collection("definições")
          .doc(settingsType ?? "contactos")
          .collection("contacto")
          .doc(id)
          .set(data ?? contact);
    } catch (e) {
      showSnackBar(
          content: "Ocorreu um erro desconhecido, tente novamente",
          context: context);
    }
  }

  getAllMercahndiseSell() async {
    final sellData =
        await db.collection("vendas").orderBy("data", descending: true).get();
    return sellData;
  }

  getAllContacts() {
    return FirebaseFirestore.instance
        .collection("definições")
        .doc("contactos")
        .collection("contacto")
        .snapshots();
  }
}
