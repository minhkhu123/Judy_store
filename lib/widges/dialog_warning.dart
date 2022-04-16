import 'package:album_app/common/images.dart';
import 'package:album_app/common/theme/app_color.dart';
import 'package:album_app/common/theme/app_text_style.dart';
import 'package:album_app/screens/home/home_controller.dart';
import 'package:album_app/widges/ct_button_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class DialogWarning extends StatelessWidget {
  final VoidCallback onPress;
  final bool isWhat;

  const DialogWarning({Key key, this.onPress, this.isWhat}) : super(key: key);
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
            height: 200,
            width: width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Center(
                      child: Text(
                        'Thông báo',
                        style: AppTextStyles.regularW500(context, size: 24, color: AppColors.blue),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                    child: Divider(
                      color: AppColors.grey,
                      thickness: 0.5,
                    ),
                  ),
                  SizedBox(height: 25),
                  Center(child: Text(isWhat ? 'Bạn chắc chắn muốn xóa thư mục này chứ?' : 'Bạn chắc chắn muốn xóa ảnh này chứ?',style: AppTextStyles.regularW500(context, size: 16,color: AppColors.black),)),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButtonAuth(
                        width: width * 0.3,
                        title: 'Đồng ý',
                        onPressed: onPress,
                      ),
                      SizedBox(width: 10),
                      CustomButtonAuth(
                        width: width * 0.3,
                        title: 'Hủy',
                        onPressed: () {
                          Get.back();
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
