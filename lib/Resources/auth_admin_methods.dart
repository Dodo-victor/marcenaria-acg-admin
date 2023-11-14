import 'package:acg_admin/models/admin_model.dart';
import 'package:acg_admin/utilis/showSnackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthAdminMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  authStateChange()  {

    return _auth.authStateChanges();

  }

  Future<bool> authAdminUserWithGoogle({required BuildContext context}) async {
    bool res = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleSignInAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuth?.idToken,
          accessToken: googleSignInAuth?.accessToken);

      final authUser = await _auth.signInWithCredential(credential);

      User? user = authUser.user;

      if (user != null) {
        if (authUser.additionalUserInfo!.isNewUser) {
          final AdminModel adminData = AdminModel(
            adminName: user.displayName!,
            photoUrl: user.photoURL!,
            uid: user.uid!,
            email: user.email!,
          );

          await _db.collection("admins").doc(user.uid).set(adminData.toMap());

        }
        res = true;
      }
       
    }  catch (e) {
      res = false;
      showSnackBar(
          content:
              "Ocorreu um erro ao autenticar. Tente mais tarde! ${e}",
          context: context);
    }

    return res;
  }
}
