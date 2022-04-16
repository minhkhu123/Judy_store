import 'dart:io';

import 'package:album_app/common/images.dart';
import 'package:album_app/common/theme/app_color.dart';
import 'package:album_app/common/theme/app_text_style.dart';
import 'package:album_app/screens/home/home_controller.dart';
import 'package:album_app/widges/ct_button_auth.dart';
import 'package:album_app/widges/ct_textfield_create_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class DialogCreateInfoImg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => Dialog(
          insetPadding: EdgeInsets.only(top: 10.0),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            margin: EdgeInsets.symmetric(horizontal: 14),
            // padding: EdgeInsets.symmetric(horizontal: 35),
            // height: controller.isMulti.value ? 460 : 360,
            width: width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Center(
                      child: Text(
                    'Tạo thông tin cho ảnh',
                    style: AppTextStyles.regularW500(context, size: 18, color: AppColors.blue),
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                    child: Divider(
                      color: AppColors.grey,
                      thickness: 0.5,
                    ),
                  ),
                  controller.isMulti.value ? Center(
                    child: Image.file(
                      controller.imageInImageInfo,
                      width: 100,
                      height: 100,
                    ),
                  ) : Container(),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mã sản phẩm:',
                          style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                        ),
                        CustomTextFieldCreateInfo(
                          hintText: 'Nhập mã sản phẩm',
                          surfix: '',
                          textEditingController: controller.codeTextEditingController,
                          error: controller.checkValidCode(),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Giá sản phẩm:',
                          style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                        ),
                        CustomTextFieldCreateInfo(
                          hintText: 'Nhập giá sản phẩm',
                          surfix: 'K',
                          textEditingController: controller.moneyTextEditingController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          error: controller.checkValidMoney(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButtonAuth(
                        // width: width * 0.3,
                        title: 'Tạo thông tin',
                        onPressed: () => controller.checkAddImage(),
                      ),
                      SizedBox(width: 10),
                      CustomButtonAuth(
                        width: width * 0.3,
                        title: 'Hủy',
                        onPressed: () {
                          Get.back();
                          controller.codeTextEditingController.clear();
                          controller.moneyTextEditingController.clear();
                          controller.blankImage.value = false;
                          controller.a = 1;
                          controller.codeList.clear();
                          controller.priceList.clear();
                          controller.timeList.clear();
                          controller.update();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          )),
    );
  }
}
