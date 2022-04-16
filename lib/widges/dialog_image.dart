import 'package:album_app/common/images.dart';
import 'package:album_app/common/theme/app_color.dart';
import 'package:album_app/common/theme/app_text_style.dart';
import 'package:album_app/screens/home/home_controller.dart';
import 'package:album_app/widges/ct_button_auth.dart';
import 'package:album_app/widges/dialog_create_info_img.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class DialogImage extends StatelessWidget {
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
            // height: 280,
            width: width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Center(
                      child: Text(
                        'Thêm ảnh vào Folder',
                        style: AppTextStyles.regularW500(context, size: 18, color: AppColors.blue),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                    child: Divider(
                      color: AppColors.grey,
                      thickness: 0.5,
                    ),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      controller.isMulti.value = false;
                      controller.checkMulti();
                      Get.back();
                      controller.imgFromCamera();
                    },
                    child: Container(
                      height: 50,
                      width: width,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: AppColors.blue4,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Image.asset(Images.ic_camera),
                          ),
                          Text('Chụp ảnh',style: AppTextStyles.regularW500(context, size: 16),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      controller.isMulti.value = false;
                      controller.checkMulti();
                      Get.back();
                      controller.imgFromGallery();
                    },
                    child: Container(
                      height: 50,
                      width: width,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: AppColors.blue4,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Image.asset(Images.ic_gallery),
                          ),
                          Text('Chọn 1 ảnh từ thư viện',style: AppTextStyles.regularW500(context, size: 16),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      controller.isMulti.value = true;
                      controller.checkMulti();
                      Get.back();
                      controller.imgMultiFromGallery();
                    },
                    child: Container(
                      height: 50,
                      width: width,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: AppColors.blue4,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Image.asset(Images.ic_gallery),
                          ),
                          Text('Chọn nhiều ảnh từ thư viện',style: AppTextStyles.regularW500(context, size: 16),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          )),
    );
  }
}
