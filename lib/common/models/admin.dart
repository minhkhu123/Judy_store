import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  static const ISREGISTER = "isRegister";

  bool isRegister = false;

  AdminModel({this.isRegister});

  AdminModel.fromSnapshot(DocumentSnapshot snapshot) {
    isRegister = (snapshot.data() as Map)[ISREGISTER];
  }
}