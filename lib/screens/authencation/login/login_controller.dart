import 'package:album_app/common/constants.dart';
import 'package:album_app/common/models/admin.dart';
import 'package:album_app/common/models/folder.dart';
import 'package:album_app/common/models/user.dart';
import 'package:album_app/constants/firebase.dart';
import 'package:album_app/routes/app_pages.dart';
import 'package:album_app/screens/authencation/login/login_screen.dart';
import 'package:album_app/screens/home/home_screen.dart';
import 'package:album_app/widges/dialog_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';
import 'package:firebase_database/firebase_database.dart';

class LoginController extends GetxController {
  Rx<User> firebaseUser;
  String usersCollection = 'users';
  Rx<UserModel> userModel = UserModel().obs;
  Rx<AdminModel> adminModel = AdminModel().obs;
  String collectionFolder = 'folder';
  RxList<FolderModel> folderModel = <FolderModel>[].obs;

  RxBool isPassword = false.obs;

  RxBool isLoggedIn = false.obs;
  RxBool isRegister = false.obs;

  void checkLogin() {
    isLoggedIn.value;
    SpUtil.putBool(ConstString.check_login, isLoggedIn.value);
    update();
  }

  TextEditingController emailTextEditingController = TextEditingController();

  String get email => emailTextEditingController.text;

  TextEditingController passwordTextEditingController = TextEditingController();

  String get password => passwordTextEditingController.text;

  void changeShow() {
    isPassword.value = !isPassword.value;
    update();
  }

  @override
  void onReady() {
    firebaseUser = Rx<User>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    adminModel.bindStream(listenToAdmin());
    ever(firebaseUser, _setInitialScreen);
    super.onReady();
  }

  @override
  void onInit() {
    emailTextEditingController.addListener(() {});
    passwordTextEditingController.addListener(() {});
    print(adminModel.value.isRegister);
    // isLoggedIn.value = SpUtil.getBool(ConstString.check_login);
    // nextScreen();
    super.onInit();
  }

  _setInitialScreen(User user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      userModel.bindStream(listenToUser());
      Get.offAll(() => HomeScreen());
    }
  }

  // Stream<List<FolderModel>> getAllFolder() =>
  //     firebaseFirestore.collection(collectionFolder).snapshots().map((query) => query.docs.map((item) => FolderModel.fromDocumentSnapshot(item)).toList());

  void login() async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    try {
      await auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim()).then((result) {
        String userId = result.user.uid;
        initializedUserModel(userId);
        Get.back();
        clearTextField();
        Get.toNamed(Routes.HOME);
        // Get.offNamed(Routes.HOME);
      });
    } catch(e) {
      debugPrint(e.toString());
      Get.back();
      Get.snackbar('Đăng nhập không thành công', 'Xin vui lòng thử lại!');
    }
    update();
  }

  void nextScreen() async {
    isLoggedIn.value ? Get.toNamed(Routes.HOME) : Get.toNamed(Routes.LOGIN);
    update();
  }

  initializedUserModel(String userId) async {
    userModel.value = await firebaseFirestore.collection(usersCollection).doc(userId).get().then((doc) => UserModel.fromSnapshot(doc));
  }

  clearTextField() {
    emailTextEditingController.clear();
    passwordTextEditingController.clear();
  }

  Stream<UserModel> listenToUser() => firebaseFirestore
      .collection(usersCollection)
      .doc(firebaseUser.value.uid)
      .snapshots()
      .map((snapshot) => UserModel.fromSnapshot(snapshot));

  Stream<AdminModel> listenToAdmin() => firebaseFirestore
      .collection('admin')
      .doc('rJkFnwqC0xz4KgKhCd0S')
      .snapshots()
      .map((snapshot) => AdminModel.fromSnapshot(snapshot));
}