import 'package:album_app/common/images.dart';
import 'package:album_app/common/theme/app_color.dart';
import 'package:album_app/common/theme/app_text_style.dart';
import 'package:album_app/screens/home/home_controller.dart';
import 'package:album_app/widges/ct_textfield_search.dart';
import 'package:album_app/widges/dialog_choose_folder_favorite.dart';
import 'package:album_app/widges/dialog_image.dart';
import 'package:album_app/widges/dialog_show_image.dart';
import 'package:album_app/widges/dialog_warning.dart';
import 'package:album_app/widges/image_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:album_app/common/money.dart';

class AlbumFolder extends GetView {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
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
              controller.checkFolderNF.value = controller.save.value;
              Get.back();
            },
          ),
          actions: [
            controller.favoriteCheck.value == '1'
                ? IconButton(
                    onPressed: () {
                      Get.dialog(DialogImage());
                    },
                    icon: Image.asset(Images.ic_add_image),
                  )
                : Container(),
          ],
          title: Text(
            controller.nameFolder.value,
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
                textEditingController: controller.searchImageTextEditingController,
                onChanged: (value) {
                  controller.getSearchListImage();
                },
              ),
              controller.imagesSearch.length == 0
                  ? Obx(
                      () => Container(
                        height: height * 0.74,
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                        child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200, childAspectRatio: 96 / 100, crossAxisSpacing: 10, mainAxisSpacing: 10),
                            itemCount: controller.images.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return ImageFile(
                                title: controller.images[index].name,
                                money: "${controller.images[index].price} K",
                                urlImage: controller.images[index].image,
                                isLiked: controller.images[index].liked,
                                onPress: () {
                                  // if (controller.checkFolderNF.value == "1" && controller.images[index].liked){
                                  //   controller.nameFolder.value = controller.images[index].favoriteFolderName;
                                  //   controller.checkNameFolder();
                                  //   controller.folderId.value = controller.images[index].favoriteFolder;
                                  //   controller.favoriteCheck.value = "2";
                                  //   controller.checkFolderID();
                                  //   controller.checkFolderNF.value = "2";
                                  //   controller.checkFolders();
                                  //   controller.getDataImage(controller.folderId.value);
                                  //   controller.getFolderName();
                                  //   controller.getSearchListImage();
                                  //   Get.to(AlbumFolder());
                                  // } else {
                                  //   Get.dialog(DialogShowImage(
                                  //     urlImage: controller.images[index].image,
                                  //     title: controller.images[index].name,
                                  //     money: controller.images[index].price,
                                  //   ));
                                  // }
                                  Get.dialog(DialogShowImage(
                                    urlImage: controller.images[index].image,
                                    title: controller.images[index].name,
                                    money: controller.images[index].price,
                                  ));
                                },
                                folderFavoriteName: controller.images[index].favoriteFolderName ?? "",
                                folderNormal: controller.checkFolderNF.value == "1" ? true : false,
                                like: controller.images[index].liked
                                    ? () => null
                                    : () {
                                        controller.bindFavoriteFolder();
                                        Get.dialog(DialogChooseFolderFavorite(
                                          onPress: () {
                                            controller.imageId.value = controller.images[index].id;
                                            controller.checkImageID();
                                            controller.addImageToFavorite(
                                                controller.favoriteFolderId.value,
                                                controller.images[index].name,
                                                controller.images[index].price,
                                                controller.images[index].image,
                                                controller.folderId.value,
                                                controller.images[index].id,
                                                controller.favoriteFolderId.value,
                                                '', '');
                                            // controller.updateImage(controller.folderId.value, controller.images[index].id, true,
                                            //     controller.favoriteFolderId.value, controller.favoriteId.value);
                                          },
                                        ));
                                      },
                                delete: () => Get.dialog(DialogWarning(
                                  isWhat: false,
                                  onPress: () {
                                    Get.back();
                                    controller.deleteImage(controller.folderId.value, controller.images[index].id);
                                    controller.images[index].origin
                                        ? controller.deleteImageFavorite(controller.images[index].favoriteFolder, controller.images[index].favoriteId)
                                        : controller.updateImage(controller.images[index].oldFolder, controller.images[index].oldId, false, "", "", '');
                                  },
                                )),
                              );
                            }),
                      ),
                    )
                  : Container(
                      height: height * 0.74,
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200, childAspectRatio: 96 / 100, crossAxisSpacing: 10, mainAxisSpacing: 10),
                          itemCount: controller.imagesSearch.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return ImageFile(
                              title: controller.imagesSearch[index].name,
                              money: "${controller.imagesSearch[index].price} K",
                              urlImage: controller.imagesSearch[index].image,
                              isLiked: controller.imagesSearch[index].liked,
                              onPress: () {
                                // if (controller.checkFolderNF.value == "1" && controller.imagesSearch[index].liked){
                                //   controller.nameFolder.value = controller.imagesSearch[index].favoriteFolderName;
                                //   controller.checkNameFolder();
                                //   controller.folderId.value = controller.imagesSearch[index].favoriteFolder;
                                //   controller.favoriteCheck.value = "2";
                                //   controller.checkFolderID();
                                //   controller.checkFolderNF.value = "2";
                                //   controller.checkFolders();
                                //   controller.getDataImage(controller.folderId.value);
                                //   controller.getFolderName();
                                //   controller.getSearchListImage();
                                //   Get.to(AlbumFolder());
                                // } else {
                                //   Get.dialog(DialogShowImage(
                                //     urlImage: controller.images[index].image,
                                //     title: controller.images[index].name,
                                //     money: controller.images[index].price,
                                //   ));
                                // }
                                Get.dialog(DialogShowImage(
                                  urlImage: controller.imagesSearch[index].image,
                                  title: controller.imagesSearch[index].name,
                                  money: controller.imagesSearch[index].price,
                                ));
                              },
                              folderFavoriteName: controller.imagesSearch[index].favoriteFolderName ?? "",
                              folderNormal: controller.checkFolderNF.value == "1" ? true : false,
                              like: controller.imagesSearch[index].liked
                                  ? () => null
                                  : () {
                                      controller.bindFavoriteFolder();
                                      Get.dialog(DialogChooseFolderFavorite(
                                        onPress: () {
                                          controller.imageId.value = controller.imagesSearch[index].id;
                                          controller.checkImageID();
                                          controller.addImageToFavorite(
                                              controller.favoriteFolderId.value,
                                              controller.imagesSearch[index].name,
                                              controller.imagesSearch[index].price,
                                              controller.imagesSearch[index].image,
                                              controller.folderId.value,
                                              controller.imagesSearch[index].id,
                                              controller.favoriteFolderId.value,
                                              '', '');
                                          // controller.updateImage(controller.folderId.value, controller.imagesSearch[index].id, true,
                                          //     controller.favoriteFolderId.value, controller.favoriteId.value);
                                        },
                                      ));
                                    },
                              delete: () => Get.dialog(DialogWarning(
                                isWhat: false,
                                onPress: () {
                                  Get.back();
                                  controller.deleteImage(controller.folderId.value, controller.imagesSearch[index].id);
                                  controller.imagesSearch[index].origin
                                      ? controller.deleteImageFavorite(
                                          controller.imagesSearch[index].favoriteFolder, controller.imagesSearch[index].favoriteId)
                                      : controller.updateImage(
                                          controller.imagesSearch[index].oldFolder, controller.imagesSearch[index].oldId, false, "", "", '');
                                },
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
