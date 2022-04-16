import 'dart:io';

import 'package:album_app/common/constants.dart';
import 'package:album_app/common/models/folder.dart';
import 'package:album_app/common/models/image.dart';
import 'package:album_app/constants/firebase.dart';
import 'package:album_app/routes/app_pages.dart';
import 'package:album_app/widges/dialog_create_info_img.dart';
import 'package:album_app/widges/dialog_loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sp_util/sp_util.dart';

class HomeController extends GetxController {
  static HomeController instance = Get.find();
  RxList<FolderModel> folderModel = <FolderModel>[].obs;
  RxList<FolderModel> favoriteFolderModel = <FolderModel>[].obs;
  RxList<FolderModel> normalFolderModel = <FolderModel>[].obs;
  String collectionFolder = 'folder';
  RxList<ImageModel> imageModel = RxList<ImageModel>();
  String collectionImage = 'image';

  List<FolderModel> get favorites => favoriteFolderModel.value;
  List<FolderModel> get normal => normalFolderModel.value;

  List<FolderModel> get folders => folderModel;

  List<ImageModel> get images => imageModel;
  List<ImageModel> imagesSearch = [];
  List<FolderModel> foldersSearch = [];
  List<FolderModel> foldersShow = [];
  List<FolderModel> favoriteFolders = [];
  RxList<String> folderName;

  TextEditingController searchFolderTextEditingController = TextEditingController();

  String get searchFolder => searchFolderTextEditingController.text;

  TextEditingController searchImageTextEditingController = TextEditingController();

  String get searchImage => searchImageTextEditingController.text;

  TextEditingController codeTextEditingController = TextEditingController();

  String get code => codeTextEditingController.text;

  TextEditingController moneyTextEditingController = TextEditingController();

  String get money => moneyTextEditingController.text;

  TextEditingController nameFolderTextEditingController = TextEditingController();

  String get nameFolderList => nameFolderTextEditingController.text;

  RxInt folder = 0.obs;
  File imageIn;
  List<XFile> imageFileList;
  RxString nameFolder = ''.obs;
  RxString folderId = ''.obs;
  RxString favoriteFolderId = ''.obs;
  RxString favoriteCheck = ''.obs;
  RxString favoriteId = ''.obs;
  RxString imageId = ''.obs;
  RxBool isMulti = false.obs;
  RxBool blankImage = false.obs;
  RxBool blankFolder = false.obs;
  File imageInImageInfo;
  RxString checkFolderNF = ''.obs;
  RxString save = ''.obs;
  RxString favoriteFolderName = ''.obs;

  void checkFolders() {
    checkFolderNF.value;
    update();
  }

  void checkMulti() {
    isMulti.value;
    update();
  }

  void checkImageID() {
    imageId.value;
    update();
  }

  void checkFolderID() {
    folderId.value;
    favoriteCheck.value;
    update();
  }

  void checkNameFolder() {
    nameFolder.value;
    update();
  }

  void checkFolder() {
    folder.value;
    blankFolder.value;
    update();
  }

  void checkFavorite() {
    favoriteFolderId.value;
    favoriteFolderName.value;
    update();
  }

  void checkFavoriteId() {
    favoriteId.value;
    update();
  }

  final ImagePicker _picker = ImagePicker();

  Future imgFromCamera() async {
    final image = await _picker.pickImage(source: ImageSource.camera);

    imageIn = File(image.path);
    Get.dialog(DialogCreateInfoImg());
    update();
  }

  Future imgFromGallery() async {
    final XFile image = await _picker.pickImage(source: ImageSource.gallery);

    imageIn = File(image.path);
    Get.dialog(DialogCreateInfoImg());
    update();
  }

  Future imgMultiFromGallery() async {
    final images = await _picker.pickMultiImage();

    imageFileList = images;
    imageInImageInfo = File(imageFileList[0].path);
    Get.dialog(DialogCreateInfoImg());
    update();
  }

  @override
  void onReady() {
    super.onReady();
    reloadDatabase();
  }

  @override
  void onInit() async {
    searchFolderTextEditingController.addListener(() {});
    searchImageTextEditingController.addListener(() {});
    super.onInit();
  }

  getFolderName(){
    folderName = <String>[].obs;
    for (int i=0; i<images.length; i++){
      for (int j=0; j<folders.length; j++){
        print(images[i].favoriteId +"----"+ folders[j].id +"\n");
        if (images[i].favoriteId == folders[j].id){
          folderName.add(folders[j].name);
          break;
        }
      }
    }
    print("getFolderName" + folderName.length.toString());
    update();
  }

  Stream<List<FolderModel>> getAllFolder() => firebaseFirestore
      .collection(collectionFolder)
      .where('dateCreated')
      .orderBy('noted', descending: true)
      .snapshots()
      .map((query) => query.docs.map((item) => FolderModel.fromDocumentSnapshot(item)).toList());

  Stream<List<ImageModel>> getAllImage(String uid) => firebaseFirestore
      .collection(collectionFolder)
      .doc(uid)
      .collection(collectionImage)
      .orderBy("dateCreated", descending: true)
      .snapshots()
      .map((query) => query.docs.map((item) => ImageModel.fromDocumentSnapshot(item)).toList());

  Stream<List<FolderModel>> getFavoriteFolders() => firebaseFirestore
      .collection(collectionFolder)
      .where('favorite', isEqualTo: '2')
      .snapshots()
      .map((query) => query.docs.map((item) => FolderModel.fromDocumentSnapshot(item)).toList());

  Stream<List<FolderModel>> getNormalFolders() => firebaseFirestore
      .collection(collectionFolder)
      .where('favorite', isEqualTo: '1')
      .snapshots()
      .map((query) => query.docs.map((item) => FolderModel.fromDocumentSnapshot(item)).toList());

  void logOut() async {
    auth.signOut();
    // Get.offNamed(Routes.LOGIN);
  }

  Future<void> getDataImage(String id) async {
    imageModel.clear();
    imageModel.bindStream(getAllImage(id));
    update();
    getFolderName();
    update();
  }

  void reloadDatabase() async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    folderModel.bindStream(getAllFolder());
    Get.back();
    update();
  }

  void addFolder(String name, String id, String favorite) async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    firebaseFirestore.collection(collectionFolder).add({
      'name': name,
      'favorite': favorite,
      'dateCreated': Timestamp.now(),
      'noted': 0,
    }).whenComplete(() {
      print(firebaseFirestore.collection(collectionFolder).id);
      clearTextField();
      getShowListFolder();
      Get.back();
      Get.back();
      Get.snackbar('Thêm thư mục', 'Bạn đã thêm thư mục thành công');
    });
    update();
  }

  void deleteFolder(String id) async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    firebaseFirestore.collection(collectionFolder).doc(id).delete().whenComplete(() {
      firebaseFirestore.collection(collectionFolder).doc(id).collection(collectionImage).get().then((value) {
        value.docs.forEach((element) {
          firebaseFirestore.collection(collectionFolder).doc(id).collection(collectionImage).doc(element.id).delete();
        });
      });
      getShowListFolder();
      update();
      Get.back();
      Get.back();
      Get.snackbar('Xóa thư mục', 'Bạn đã xóa thư mục thành công');
    });
    update();
  }

  void updateFolder(String id, int noted) {
    firebaseFirestore.collection(collectionFolder).doc(id).update({
      'noted': noted,
    }).whenComplete(() {
      getShowListFolder();
      update();
      print('note thành công');
    });
    update();
  }

  void addImage(String folderId, String code, String price, bool liked) async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    var taskSnapshot = await firebase_storage.FirebaseStorage.instance.ref().child(imageIn.path.split('/').last).putFile(imageIn);
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    await firebaseFirestore.collection(collectionFolder).doc(folderId).collection(collectionImage).add({
      'name': code,
      'price': price,
      'image': downloadUrl,
      'liked': liked,
      'dateCreated': Timestamp.now(),
      'favoriteFolder': '',
      'favoriteId': '',
      'oldFolder': '',
      'oldId': '',
      'origin': true,
    }).whenComplete(() {
      clearTextField();
      imagesSearch.clear();
      imagesSearch.addAll(images);
      Get.back();
      Get.back();
      Get.snackbar('Thêm ảnh', 'Bạn đã thêm ảnh thành công');
    });
    update();
  }

  void deleteImage(String folderID, String id) async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    firebaseFirestore.collection(collectionFolder).doc(folderID).collection(collectionImage).doc(id).delete().whenComplete(() {
      images.clear();
      imagesSearch.clear();
      getDataImage(folderId.value);
      update();
      Get.back();
      Get.snackbar('Xóa ảnh', 'Bạn đã xóa ảnh thành công');
    });
    update();
  }

  void deleteImageFavorite(String folderID, String id) async {
    firebaseFirestore.collection(collectionFolder).doc(folderID ?? '').collection(collectionImage).doc(id ?? '').delete().whenComplete(() {
      images.clear();
      imagesSearch.clear();
      getDataImage(folderId.value);
    });
    update();
  }

  int a = 1;
  List<String> codeList = [];
  List<String> priceList = [];
  List<Timestamp> timeList = [];

  void saveInfoMultiImage(String code, String price) async {
    if (a < imageFileList.length) {
      codeList.add(code);
      priceList.add(price);
      timeList.add(Timestamp.now());
      codeTextEditingController.clear();
      moneyTextEditingController.clear();
      imageInImageInfo = File(imageFileList[a].path);
      a++;
    } else if (a == imageFileList.length) {
      codeList.add(code);
      priceList.add(price);
      timeList.add(Timestamp.now());
      addMultiImage(folderId.value, code, price);
    }
    update();
  }

  void addMultiImage(String folderId, String code, String price) async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    for (int i = 0; i < imageFileList.length; i++) {
      //   for (var img in imageFileList) {
      var taskSnapshot =
          await firebase_storage.FirebaseStorage.instance.ref().child(imageFileList[i].path.split('/').last).putFile(File(imageFileList[i].path));
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      await firebaseFirestore.collection(collectionFolder).doc(folderId).collection(collectionImage).add({
        'name': codeList[i],
        'price': priceList[i],
        'image': downloadUrl,
        'liked': false,
        'dateCreated': timeList[i],
        'favoriteFolder': '',
        'favoriteId': '',
        'oldFolder': '',
        'oldId': '',
        'origin': true,
      }).whenComplete(() {
        clearTextField();
        imagesSearch.clear();
        imagesSearch.addAll(images);
        Get.back();
      });
    }
    // Get.back();
    // Get.back();
    a = 1;
    codeList.clear();
    priceList.clear();
    timeList.clear();
    Get.snackbar('Thêm ảnh', 'Bạn đã thêm ảnh thành công');
    // }
    update();
  }

  Future<void> getSearchListImage() async {
    if (searchImage == '' || searchImage.isEmpty) {
      imagesSearch = [];
      imagesSearch.addAll(images);
    } else {
      imagesSearch = [];
      update();
      for (int i = 0; i < images.length; i++) {
        if (images.elementAt(i).name.toString().toLowerCase().contains(searchImage.toLowerCase())) {
          imagesSearch.add(images[i]);
        }
      }
    }
    update();
  }

  Future<void> getSearchListFolder() async {
    if (searchFolder == '' || searchFolder.isEmpty) {
      foldersSearch = [];
      foldersSearch.addAll(foldersShow);
    } else {
      foldersSearch = [];
      update();
      for (int i = 0; i < foldersShow.length; i++) {
        if (foldersShow.elementAt(i).name.toString().toLowerCase().contains(searchFolder.toLowerCase())) {
          foldersSearch.add(foldersShow[i]);
        }
      }
    }
    update();
  }

  Future<void> getShowListFolder() async {
      foldersShow = [];
      update();
      for (int i = 0; i < folders.length; i++) {
        if (folders.elementAt(i).favorite.toLowerCase().contains(checkFolderNF.value)) {
          foldersShow.add(folders[i]);
        }
      }
      getSearchListFolder();
    update();
  }

  void bindFavoriteFolder() {
    favoriteFolderModel.bindStream(getFavoriteFolders());
    update();
  }

  void bindNormalFolder() {
    normalFolderModel.bindStream(getNormalFolders());
    update();
  }

  void addImageToFavorite(
      String folderID, String code, String price, String urlImage, String oldFolder, String oldId, String favoriteFolder, String favoriteID, String favoriteNameFolder) async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    await firebaseFirestore.collection(collectionFolder).doc(folderID).collection(collectionImage).add({
      'name': code,
      'image': urlImage,
      'price': price,
      'liked': true,
      'dateCreated': Timestamp.now(),
      'oldFolder': oldFolder,
      'oldId': oldId,
      'favoriteFolder': favoriteFolder,
      'favoriteId': favoriteID,
      'favoriteNameFolder': favoriteNameFolder,
      'origin': false,
    }).then((docRef) {
      favoriteId.value = docRef.id;
      checkFavoriteId();
    }).whenComplete(() {
      clearTextField();
      images.clear();
      imagesSearch.clear();
      getDataImage(folderId.value);
      Get.back();
      Get.back();
      Get.snackbar('Thêm ảnh yêu thích', 'Bạn đã thêm ảnh vào mục yêu thích thành công');
    });
    imagesSearch.length == 0
        ? updateImage(folderId.value, imageId.value, true, favoriteFolderId.value, favoriteId.value, favoriteFolderName.value)
        : updateImage(folderId.value, imageId.value, true, favoriteFolderId.value, favoriteId.value, favoriteFolderName.value);
    favoriteFolderId.value = '';
    update();
  }

  void updateImage(String folderId, String id, bool liked, String favoriteFolder, String favoriteID, String favoriteFolderName) {
    firebaseFirestore.collection(collectionFolder).doc(folderId).collection(collectionImage).doc(id).update({
      'liked': liked,
      'favoriteFolder': favoriteFolder,
      'favoriteId': favoriteID,
      'favoriteFolderName': favoriteFolderName,
    }).whenComplete(() {
      imagesSearch.clear();
      imagesSearch.addAll(images);
      update();
    });
    update();
  }

  void clearTextField() {
    nameFolderTextEditingController.clear();
    folder.value = 0;
    codeTextEditingController.clear();
    moneyTextEditingController.clear();
    update();
  }

  void checkAddFolder() {
    if (nameFolderTextEditingController.text == "" || folder.value == 0) {
      blankFolder.value = true;
      Get.snackbar('Thông báo', 'Bạn chưa điền dủ thông tin');
    } else {
      blankFolder.value = false;
      addFolder(nameFolderTextEditingController.text, '', folder.value.toString());
    }
    update();
  }

  void checkAddImage() {
    if (codeTextEditingController.text == "" || moneyTextEditingController.text == "") {
      blankImage.value = true;
      Get.snackbar('Thông báo', 'Bạn chưa điền dủ thông tin');
    } else {
      if (isMulti.value) {
        saveInfoMultiImage(codeTextEditingController.text, moneyTextEditingController.text);
        // addMultiImage(folderId.value, codeTextEditingController.text, moneyTextEditingController.text);
      } else {
        blankImage.value = false;
        addImage(folderId.value, codeTextEditingController.text, moneyTextEditingController.text, false);
      }
    }
    update();
  }

  String checkValidCode() {
    if (code == "" && blankImage.value) {
      return 'Bạn chưa nhập mã sản phẩm';
    }
    return null;
  }

  String checkValidMoney() {
    if (money == "" && blankImage.value) {
      return 'Bạn chưa nhập giá sản phẩm';
    }
    return null;
  }

  String checkValidFolder() {
    if (nameFolderList == "" && blankFolder.value) {
      return 'Bạn chưa nhập tên Folder';
    }
    return null;
  }
}
