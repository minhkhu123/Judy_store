import 'package:cloud_firestore/cloud_firestore.dart';

class FolderModel{
  static const ID = "id";
  static const NAME = "name";
  static const FAVORITE = "favorite";
  static const DATECREATED = "dateCreated";
  static const NOTED = "noted";

  String id;
  String name;
  String favorite;
  Timestamp dateCreated;
  String noted;

  FolderModel({this.id, this.name, this.favorite, this.dateCreated, this.noted});

  FolderModel.fromDocumentSnapshot(DocumentSnapshot data){
    id = data.id;
    name = data[NAME];
    favorite = data[FAVORITE];
    dateCreated = data[DATECREATED];
    noted = data[NOTED].toString();
  }

}
