import 'package:album_app/common/images.dart';
import 'package:album_app/common/theme/app_color.dart';
import 'package:album_app/common/theme/app_text_style.dart';
import 'package:album_app/screens/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteFolderTile extends StatelessWidget {
  final String name;
  final VoidCallback onPress;
  final int index;

  const FavoriteFolderTile({Key key, this.name, this.onPress, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => InkWell(
        onTap: onPress,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: controller.favorites[index].id == controller.favoriteFolderId.value ? Image.asset(Images.ic_checked) : Image.asset(Images.ic_unchecked),
              // child: Image.asset(Images.ic_unchecked),
            ),
            Text(
              name,
              style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black),
            ),
          ],
        ),
      ),
    );
  }
}
