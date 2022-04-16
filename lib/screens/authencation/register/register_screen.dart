import 'package:album_app/common/images.dart';
import 'package:album_app/common/theme/app_color.dart';
import 'package:album_app/common/theme/app_text_style.dart';
import 'package:album_app/screens/authencation/register/register_controller.dart';
import 'package:album_app/widges/ct_button_auth.dart';
import 'package:album_app/widges/ct_textfield_icon.dart';
import 'package:album_app/widges/ct_textfield_unicon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GetBuilder<RegisterController>(
                init: RegisterController(),
                builder: (controller) => Column(
                  children: [
                    SizedBox(height: 100),
                    Text(
                      'ĐĂNG KÝ',style: AppTextStyles.regularW700(context, size: 30,color: AppColors.blue),
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
                    SizedBox(height: 15),
                    CustomTextFieldLogin(
                      isPassword: controller.isConfirmPassword.value,
                      hintText: 'Nhập lại mật khẩu',
                      textEditingController: controller.confirmPasswordTextEditingController,
                      iconPre: SvgPicture.asset(Images.ic_lock),
                      iconData: controller.isConfirmPassword.value
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
                    // SizedBox(height: 15),
                    // CustomTextFieldLoginUnIcon(
                    //   isPassword: false,
                    //   hintText: 'Nhập họ tên',
                    //   textEditingController: controller.emailTextEditingController,
                    //   keyboardType: TextInputType.emailAddress,
                    //   iconPre: SvgPicture.asset(Images.ic_email),
                    // ),
                    // SizedBox(height: 15),
                    // CustomTextFieldLoginUnIcon(
                    //   isPassword: false,
                    //   hintText: 'Nhập số điện thoại',
                    //   textEditingController: controller.emailTextEditingController,
                    //   keyboardType: TextInputType.emailAddress,
                    //   iconPre: SvgPicture.asset(Images.ic_email),
                    // ),
                    SizedBox(height: 30),
                    CustomButtonAuth(
                      title: 'Đăng ký',
                      onPressed: () {
                        controller.register();
                      },
                      width: width * 0.7,
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Bạn đã có tài khoản ? ',style: AppTextStyles.regularW400(context, size: 16,color: AppColors.grey),),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Center(
                            child: Text('Đăng nhập ngay',style: AppTextStyles.regularW700(context, size: 18,color: AppColors.blue),),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
    ));
  }
}
