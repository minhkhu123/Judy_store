import 'package:album_app/common/images.dart';
import 'package:album_app/common/theme/app_color.dart';
import 'package:album_app/common/theme/app_text_style.dart';
import 'package:album_app/screens/home/album_folder.dart';
import 'package:album_app/screens/home/home_controller.dart';
import 'package:album_app/widges/ct_textfield_search.dart';
import 'package:album_app/widges/dialog_folder.dart';
import 'package:album_app/widges/dialog_warning.dart';
import 'package:album_app/widges/folder_normal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FolderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.blue,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
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
              SizedBox(height: 10),
              CustomSearchTextField(
                textEditingController: controller.searchFolderTextEditingController,
                onChanged: (value) {
                  controller.getSearchListFolder();
                },
              ),
              controller.foldersSearch.length == 0
                  ? Container(
                      height: height * 0.74,
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200, childAspectRatio: 3 / 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
                          itemCount: controller.foldersShow.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return FolderNormal(
                              title: controller.foldersShow[index].name,
                              onPress: () async {
                                controller.nameFolder.value = controller.foldersShow[index].name;
                                controller.checkNameFolder();
                                controller.folderId.value = controller.foldersShow[index].id;
                                controller.favoriteCheck.value = controller.foldersShow[index].favorite;
                                controller.checkFolderID();
                                await controller.getDataImage(controller.folderId.value);
                                await controller.getSearchListImage();
                                Get.to(AlbumFolder());
                              },
                              noted: controller.foldersShow[index].noted,
                              favorite: controller.foldersShow[index].favorite,
                              top: () {
                                int.parse(controller.foldersShow[index].noted) == 0
                                    ? controller.updateFolder(controller.foldersShow[index].id, 1)
                                    : controller.updateFolder(controller.foldersShow[index].id, 0);
                              },
                              delete: () => Get.dialog(DialogWarning(
                                isWhat: true,
                                onPress: () => controller.deleteFolder(controller.foldersShow[index].id),
                              )),
                            );
                          }),
                    )
                  : Container(
                      height: height * 0.74,
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200, childAspectRatio: 3 / 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
                          itemCount: controller.foldersSearch.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return FolderNormal(
                              title: controller.foldersSearch[index].name,
                              onPress: () {
                                controller.nameFolder.value = controller.foldersSearch[index].name;
                                controller.checkNameFolder();
                                controller.folderId.value = controller.foldersSearch[index].id;
                                controller.favoriteCheck.value = controller.foldersSearch[index].favorite;
                                controller.checkFolderID();
                                controller.getDataImage(controller.folderId.value);
                                controller.getSearchListImage();
                                Get.to(AlbumFolder());
                              },
                              noted: controller.foldersSearch[index].noted,
                              favorite: controller.foldersSearch[index].favorite,
                              top: () {
                                int.parse(controller.foldersSearch[index].noted) == 0
                                    ? controller.updateFolder(controller.foldersSearch[index].id, 1)
                                    : controller.updateFolder(controller.foldersSearch[index].id, 0);
                              },
                              delete: () => Get.dialog(DialogWarning(
                                isWhat: true,
                                onPress: () => controller.deleteFolder(controller.foldersSearch[index].id),
                              )),
                            );
                          }),
                    ),
            ],
          ),
        ),
      ),
    ));
  }
}
