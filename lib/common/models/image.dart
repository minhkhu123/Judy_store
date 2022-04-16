import 'package:cloud_firestore/cloud_firestore.dart';

class ImageModel {
  static const ID = "id";
  static const IMAGE = "image";
  static const LIKED = "liked";
  static const NAME = "name";
  static const PRICE = "price";
  static const DATECREATED = 'dateCreated';
  static const FAVORITEFOLDER = 'favoriteFolder';
  static const FAVORITEID = 'favoriteId';
  static const FAVORITEFOLDERNAME = 'favoriteFolderName';
  static const OLDFOLDER = 'oldFolder';
  static const OLDID = 'oldId';
  static const ORIGIN = 'origin';

  String id;
  String image;
  bool liked;
  String name;
  String price;
  Timestamp dateCreated;
  String favoriteFolder;
  String favoriteId;
  String favoriteFolderName;
  String oldFolder;
  String oldId;
  bool origin;

  ImageModel(
      {this.id,
      this.image,
      this.liked,
      this.name,
      this.price,
      this.dateCreated,
      this.favoriteFolder,
      this.favoriteId,
      this.favoriteFolderName,
      this.oldFolder,
      this.oldId,
      this.origin});

  ImageModel.fromDocumentSnapshot(DocumentSnapshot data) {
    id = data.id;
    image = (data.data() as Map)[IMAGE];
    liked = (data.data() as Map)[LIKED];
    name = (data.data() as Map)[NAME];
    price = (data.data() as Map)[PRICE];
    dateCreated = (data.data() as Map)[DATECREATED];
    favoriteFolder = (data.data() as Map)[FAVORITEFOLDER];
    favoriteId = (data.data() as Map)[FAVORITEID];
    favoriteFolderName = (data.data() as Map)[FAVORITEFOLDERNAME];
    oldFolder = (data.data() as Map)[OLDFOLDER];
    oldId = (data.data() as Map)[OLDID];
    origin = (data.data() as Map)[ORIGIN];
  }
}
