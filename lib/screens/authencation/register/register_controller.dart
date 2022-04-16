import 'package:album_app/common/models/user.dart';
import 'package:album_app/constants/firebase.dart';
import 'package:album_app/routes/app_pages.dart';
import 'package:album_app/screens/home/home_screen.dart';
import 'package:album_app/widges/dialog_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  Rx<User> firebaseUser;
  String usersCollection = 'users';
  Rx<UserModel> userModel = UserModel().obs;

  RxBool isPassword = false.obs;
  RxBool isConfirmPassword = false.obs;

  TextEditingController emailTextEditingController = TextEditingController();

  String get email => emailTextEditingController.text;

  TextEditingController passwordTextEditingController = TextEditingController();

  String get password => passwordTextEditingController.text;

  TextEditingController confirmPasswordTextEditingController = TextEditingController();

  String get confirmPassword => confirmPasswordTextEditingController.text;

  void changeShow() {
    isPassword.value = !isPassword.value;
    update();
  }

  void changeConfirmShow() {
    isConfirmPassword.value = !isConfirmPassword.value;
    update();
  }

  @override
  void onReady() {
    firebaseUser = Rx<User>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    super.onReady();
  }

  @override
  void onInit() {
    emailTextEditingController.addListener(() {});
    passwordTextEditingController.addListener(() {});
    confirmPasswordTextEditingController.addListener(() {});
    super.onInit();
  }

  void register() async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    try {
      await auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim()).then((result) {
        String userId = result.user.uid;
        addUserFireStore(userId);
        initializedUserModel(userId);
        Get.back();
        clearTextField();
        Get.toNamed(Routes.HOME);
        // Get.offNamed(Routes.HOME);
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.back();
      Get.snackbar('Đăng ký không thành công', 'Xin vui lòng thử lại!');
    }
    update();
  }

  addUserFireStore(String userId) {
    firebaseFirestore.collection(usersCollection).doc(userId).set({
      'id': userId,
      'email': email.trim(),
    });
  }

  initializedUserModel(String userId) async {
    userModel.value = await firebaseFirestore.collection(usersCollection).doc(userId).get().then((doc) => UserModel.fromSnapshot(doc));
  }

  clearTextField() {
    emailTextEditingController.clear();
    passwordTextEditingController.clear();
    confirmPasswordTextEditingController.clear();
  }
}
