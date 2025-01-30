import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class UserDataModel {
  UserDataModel(
      {this.id = '',
      this.name = '',
      this.email,
      this.gender,
      this.emailVerified
      });

  String? id;
  String? name;
  String? email;
  String? gender;
  bool? emailVerified;
  factory UserDataModel.fromDocumentSnapshot(DocumentSnapshot doc) =>
      UserDataModel(
          id: doc["uid"],
          name: doc["name"],
          email: doc["email"],
          gender: doc["gender"],
          emailVerified: doc["emailVerified"],
          );

  Map<String, dynamic> toMap() => {
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "name": name,
        "email": email,
        "gender": gender,
        "emailVerified":emailVerified
      };
}