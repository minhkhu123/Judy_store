import 'package:album_app/common/images.dart';
import 'package:album_app/common/theme/app_color.dart';
import 'package:album_app/common/theme/app_text_style.dart';
import 'package:album_app/screens/home/home_controller.dart';
import 'package:album_app/widges/ct_button_auth.dart';
import 'package:album_app/widges/favorite_folder_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class DialogChooseFolderFavorite extends StatelessWidget {
  final VoidCallback onPress;

  const DialogChooseFolderFavorite({Key key, this.onPress}) : super(key: key);

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
                    'Folder yêu thích',
                    style: AppTextStyles.regularW500(context, size: 24, color: AppColors.blue),
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                    child: Divider(
                      color: AppColors.grey,
                      thickness: 0.5,
                    ),
                  ),
                  Obx(
                    () => Container(
                      height: 180,
                      child: ListView.builder(
                        itemCount: controller.favorites.length,
                        itemBuilder: (context, index) => FavoriteFolderTile(
                          name: controller.favorites[index].name,
                          onPress: () {
                            controller.favoriteFolderId.value = controller.favorites[index].id;
                            controller.favoriteFolderName.value = controller.favorites[index].name;
                            controller.checkFavorite();
                          },
                          index: index,
                        ),
                      ),
                    ),
                  ),
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
                          controller.favoriteFolderId.value = '';
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
