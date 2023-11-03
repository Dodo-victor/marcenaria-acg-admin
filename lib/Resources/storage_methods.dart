import 'dart:typed_data';

import 'package:acg_admin/utilis/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  deleteProductImage(context,
      {required String childName, required String productId}) async {
    try {
      await _storage.ref().child(childName).child(productId).delete();
    } catch (e) {
      showSnackBar(
          content: "Ocorreu um erro por favor tente novamente",
          context: context);
    }
  }

  saveProductImage(
      {required String childName,
      required Uint8List file,
      context,
      required String productId}) async {
    try {
      Reference ref = _storage.ref().child(childName).child(productId);
      UploadTask uploadTask = ref.putData(file);
      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      showSnackBar(
          content: "Ocorreu um erro por favor tente novamente.",
          context: context);
    }
  }
}
