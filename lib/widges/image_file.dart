import 'package:album_app/common/images.dart';
import 'package:album_app/common/theme/app_color.dart';
import 'package:album_app/common/theme/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ImageFile extends StatelessWidget {
  final String title;
  final String money;
  final VoidCallback onPress;
  final VoidCallback like;
  final VoidCallback delete;
  final String urlImage;
  final bool isLiked;
  final bool folderNormal;
  final String folderFavoriteName;

  const ImageFile(
      {Key key,
      this.title,
      this.money,
      this.onPress,
      this.like,
      this.delete,
      this.urlImage,
      this.isLiked,
      this.folderNormal,
      this.folderFavoriteName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onPress,
      child: Stack(
        children: [
          Container(
            height: height * 0.33,
            width: width * 0.6,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Container(
                    height: height * 0.23,
                    width: width * 0.5,
                    child: Image.network(
                      urlImage,
                      fit: BoxFit.fitWidth,
                    )),
                if (folderNormal && isLiked) Positioned(
                  top: 0,
                  left: 10,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.red,
                    ),
                    child: Center(
                      child: Text(
                        folderFavoriteName ?? "",
                        style: TextStyle(color: Colors.yellow),
                      ),
                    ),
                  ),
                ) else SizedBox(),
                SizedBox(height: 20),
                (folderNormal && isLiked)?SizedBox():Positioned(
                  top: 5,
                  left: 13,
                  child: InkWell(
                    onTap: like,
                    child: Container(
                        height: 24,
                        width: 24,
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: AppColors.red1,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: SvgPicture.asset(
                          Images.ic_heart,
                          color: isLiked ? AppColors.red : AppColors.white,
                        )),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.amber,
                        child: Text(
                          '$title',
                          style: AppTextStyles.regularW500(context, size: 14, color: AppColors.red),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ))),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: delete,
              child: Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    color: AppColors.white,
                  ),
                  child: Icon(
                    Icons.cancel,
                    size: 24,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
