import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const ID = "id";
  static const EMAIL = "email";

  String id;
  String email;

  UserModel({this.id, this.email});

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    email = (snapshot.data() as Map)[EMAIL];
    id = (snapshot.data() as Map)[ID];
  }
}