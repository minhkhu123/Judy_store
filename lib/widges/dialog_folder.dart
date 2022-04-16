import 'package:album_app/common/images.dart';
import 'package:album_app/common/theme/app_color.dart';
import 'package:album_app/common/theme/app_text_style.dart';
import 'package:album_app/screens/home/home_controller.dart';
import 'package:album_app/widges/ct_button_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class DialogFolder extends StatelessWidget {
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
            height: 300,
            width: width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Center(
                      child: Text(
                    'Chọn dạng Folder',
                    style: AppTextStyles.regularW500(context, size: 24, color: AppColors.blue),
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                    child: Divider(
                      color: AppColors.grey,
                      thickness: 0.5,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.folder.value = 1;
                      controller.checkFolder();
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: controller.folder.value == 1 ? Image.asset(Images.ic_checked) : Image.asset(Images.ic_unchecked),
                        ),
                        Text(
                          'Folder thường',
                          style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: AppColors.grey,
                    thickness: 0.5,
                  ),
                  InkWell(
                    onTap: () {
                      controller.folder.value = 2;
                      controller.checkFolder();
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: controller.folder.value == 2 ? Image.asset(Images.ic_checked) : Image.asset(Images.ic_unchecked),
                        ),
                        Text(
                          'Folder sản phẩm yêu thích',
                          style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: AppColors.grey,
                    thickness: 0.5,
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Tên Folder:',
                          style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                        ),
                        SizedBox(width: 7),
                        Container(
                          width: width * 0.6,
                          // height: 50,
                          child: TextFormField(
                            controller: controller.nameFolderTextEditingController,
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: AppColors.hintText),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                              hintText: 'Nhập tên Folder',
                              hintStyle: TextStyle(color: AppColors.hintText),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.hintText),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.hintText),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.hintText),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              isDense: true,
                              errorText: controller.checkValidFolder(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButtonAuth(
                        width: width * 0.3,
                        title: 'Đồng ý',
                        onPressed: () => controller.checkAddFolder(),
                      ),
                      SizedBox(width: 10),
                      CustomButtonAuth(
                        width: width * 0.3,
                        title: 'Hủy',
                        onPressed: () {
                          Get.back();
                          controller.folder.value = 0;
                          controller.blankFolder.value = false;
                          controller.checkFolder();
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
