import 'dart:io';

import 'package:album_app/common/images.dart';
import 'package:album_app/common/theme/app_color.dart';
import 'package:album_app/common/theme/app_text_style.dart';
import 'package:album_app/common/utils.dart';
import 'package:album_app/screens/home/album_folder.dart';
import 'package:album_app/screens/home/folder_screen.dart';
import 'package:album_app/screens/home/home_controller.dart';
import 'package:album_app/widges/ct_textfield_search.dart';
import 'package:album_app/widges/dialog_folder.dart';
import 'package:album_app/widges/dialog_warning.dart';
import 'package:album_app/widges/folder_normal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: SafeArea(
          child: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) => Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.blue,
            leading: IconButton(
              icon: Image.asset(Images.ic_add_folder),
              onPressed: () {
                Get.dialog(DialogFolder());
              },
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    controller.logOut();
                  },
                  icon: Icon(Icons.logout)),
            ],
            title: Text(
              'Album',
              style: AppTextStyles.regularW500(context, size: 18),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.checkFolderNF.value = "1";
                        controller.save.value = "1";
                        controller.getShowListFolder();
                        Get.to(FolderScreen());
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(Images.folder),
                          Text('Folder thường', style: AppTextStyles.regularW400(context, size: 10, color: AppColors.black),),
                        ],
                      ),
                    ),
                    SizedBox(width: 40),
                    InkWell(
                      onTap: () {
                        controller.checkFolderNF.value = "2";
                        controller.save.value = "2";
                        controller.getShowListFolder();
                        Get.to(FolderScreen());
                        },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(Images.favor_folder),
                          Text('Folder yêu thích', style: AppTextStyles.regularW400(context, size: 10, color: AppColors.black),),
                        ],
                      ),
                    ),
                  ],
                )
                // CustomSearchTextField(
                //   textEditingController: controller.searchFolderTextEditingController,
                //   onChanged: (value) {
                //     controller.getSearchListFolder();
                //   },
                // ),
                // controller.foldersSearch.length == 0
                //     ? Obx(
                //         () => Container(
                //           height: height * 0.74,
                //           margin: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                //           child: GridView.builder(
                //               gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                //                   maxCrossAxisExtent: 200, childAspectRatio: 3 / 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
                //               itemCount: controller.folders.length,
                //               itemBuilder: (BuildContext ctx, index) {
                //                 return FolderNormal(
                //                   title: controller.folders[index].name,
                //                   onPress: () {
                //                     controller.nameFolder.value = controller.folders[index].name;
                //                     controller.checkNameFolder();
                //                     controller.folderId.value = controller.folders[index].id;
                //                     controller.favoriteCheck.value = controller.folders[index].favorite;
                //                     controller.checkFolderID();
                //                     controller.getDataImage(controller.folderId.value);
                //                     controller.getSearchListImage();
                //                     Get.to(AlbumFolder());
                //                   },
                //                   noted: controller.folders[index].noted,
                //                   favorite: controller.folders[index].favorite,
                //                   top: () {
                //                     int.parse(controller.folders[index].noted) == 0
                //                         ? controller.updateFolder(controller.folders[index].id, 1)
                //                         : controller.updateFolder(controller.folders[index].id, 0);
                //                   },
                //                   delete: () => Get.dialog(DialogWarning(
                //                     isWhat: true,
                //                     onPress: () => controller.deleteFolder(controller.folders[index].id),
                //                   )),
                //                 );
                //               }),
                //         ),
                //       )
                //     : Container(
                //         height: height * 0.74,
                //         margin: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                //         child: GridView.builder(
                //             gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                //                 maxCrossAxisExtent: 200, childAspectRatio: 3 / 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
                //             itemCount: controller.foldersSearch.length,
                //             itemBuilder: (BuildContext ctx, index) {
                //               return FolderNormal(
                //                 title: controller.foldersSearch[index].name,
                //                 onPress: () {
                //                   controller.nameFolder.value = controller.foldersSearch[index].name;
                //                   controller.checkNameFolder();
                //                   controller.folderId.value = controller.foldersSearch[index].id;
                //                   controller.favoriteCheck.value = controller.foldersSearch[index].favorite;
                //                   controller.checkFolderID();
                //                   controller.getDataImage(controller.folderId.value);
                //                   controller.getSearchListImage();
                //                   Get.to(AlbumFolder());
                //                 },
                //                 noted: controller.foldersSearch[index].noted,
                //                 favorite: controller.foldersSearch[index].favorite,
                //                 top: () {
                //                   int.parse(controller.foldersSearch[index].noted) == 0
                //                       ? controller.updateFolder(controller.foldersSearch[index].id, 1)
                //                       : controller.updateFolder(controller.foldersSearch[index].id, 0);
                //                 },
                //                 delete: () => Get.dialog(DialogWarning(
                //                   isWhat: true,
                //                   onPress: () => controller.deleteFolder(controller.foldersSearch[index].id),
                //                 )),
                //               );
                //             }),
                //       ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Future<void> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Utils.showToast('Bấm trở về lần nữa để thoát app');
      return Future.value();
    }
    return Future.value(exit(0));
  }
}
