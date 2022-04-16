import 'package:album_app/common/images.dart';
import 'package:album_app/common/theme/app_color.dart';
import 'package:album_app/common/theme/app_text_style.dart';
import 'package:album_app/screens/home/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class DialogShowImage extends StatelessWidget {
  final String urlImage;
  final String title;
  final String money;

  const DialogShowImage({Key key, this.urlImage, this.title, this.money}) : super(key: key);

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
            // height: height * 0.5,
            width: width,
            child: Stack(
              children: [
                Container(
                    width: width,
                    child: Image.network(urlImage,fit: BoxFit.fill,)),
                SizedBox(height: 20),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                      // width: width * 0.3,
                      // height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      decoration: BoxDecoration(
                      color: AppColors.orange2,
                      borderRadius: BorderRadius.only( bottomLeft: Radius.circular(16))
                  ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(title,style: AppTextStyles.regularW700(context, size: 18,color: AppColors.red),overflow: TextOverflow.ellipsis,),
                          SizedBox(height: 5),
                          Text('$money K',style: AppTextStyles.regularW700(context, size: 16,color: AppColors.red), overflow: TextOverflow.ellipsis,),
                        ],
                      )),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                      width: width * 0.1,
                      height: 40,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only( bottomRight: Radius.circular(16))
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios,color: AppColors.black,),
                        onPressed: () => Get.back(),
                      )
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
