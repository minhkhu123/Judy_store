import 'package:album_app/common/constants.dart';
import 'package:album_app/common/images.dart';
import 'package:album_app/common/theme/app_color.dart';
import 'package:album_app/common/theme/app_text_style.dart';
import 'package:album_app/screens/authencation/login/login_controller.dart';
import 'package:album_app/screens/authencation/register/register_screen.dart';
import 'package:album_app/screens/home/home_screen.dart';
import 'package:album_app/widges/ct_button_auth.dart';
import 'package:album_app/widges/ct_textfield_icon.dart';
import 'package:album_app/widges/ct_textfield_unicon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: GetBuilder<LoginController>(
          init: LoginController(),
          builder: (controller) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                Text(
                  'ĐĂNG NHẬP',
                  style: AppTextStyles.regularW700(context, size: 30, color: AppColors.blue),
                ),
                SizedBox(height: 100),
                CustomTextFieldLoginUnIcon(
                  isPassword: false,
                  hintText: 'Nhập Email',
                  textEditingController: controller.emailTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  iconPre: SvgPicture.asset(Images.ic_email),
                ),
                SizedBox(height: 15),
                CustomTextFieldLogin(
                  isPassword: controller.isPassword.value,
                  hintText: 'Nhập mật khẩu',
                  textEditingController: controller.passwordTextEditingController,
                  iconPre: SvgPicture.asset(Images.ic_lock),
                  iconData: controller.isPassword.value
                      ? SvgPicture.asset(
                          Images.ic_eye_close,
                        )
                      : SvgPicture.asset(
                          Images.ic_eye,
                          color: AppColors.blue,
                        ),
                  onPressed: () {
                    controller.changeShow();
                  },
                ),
                SizedBox(height: 30),
                CustomButtonAuth(
                  title: 'Đăng nhập',
                  onPressed: () {
                    // controller.isLoggedIn.value = true;
                    // controller.checkLogin();
                    controller.login();
                  },
                  width: width * 0.7,
                ),
                SizedBox(height: 40),
                Obx(
                  () => (controller.adminModel.value.isRegister != null && controller.adminModel.value.isRegister)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Bạn chưa có tài khoản ? ',
                              style: AppTextStyles.regularW400(context, size: 16, color: AppColors.grey),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(RegisterScreen());
                                controller.emailTextEditingController.clear();
                                controller.passwordTextEditingController.clear();
                              },
                              child: Center(
                                child: Text(
                                  'Đăng ký ngay',
                                  style: AppTextStyles.regularW700(context, size: 18, color: AppColors.blue),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
