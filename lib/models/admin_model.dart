import 'dart:convert';

import 'package:flutter/cupertino.dart';

class AdminModel {
  final String adminName;
  final String photoUrl;
  final String uid;
  final String email;

  AdminModel({
    required this.adminName,
    required this.photoUrl,
    required this.uid,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      "nome": adminName,
      "foto": photoUrl,
      "uid": uid,
      "email": email,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory AdminModel.fromMap(map) {
    return AdminModel(
      adminName: map["nome"],
      photoUrl: map["foto"],
      uid: map["uid"],
      email: map["email"],
    );
  }

  factory AdminModel.fromJson(source) => AdminModel.fromMap(
        jsonDecode(source),
      );
}
