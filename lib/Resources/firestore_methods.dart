import 'dart:typed_data';

import 'package:acg_admin/Resources/storage_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../models/merchandise_model.dart';

class FirestoreMethods {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final StorageMethods _storage = StorageMethods();

  getRequestClient() async {

    final requestData =  await db.collection("solicitação").get();

    return requestData.docs;

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
      hasRequest: false,
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
}
