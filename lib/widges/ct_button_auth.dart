import 'package:album_app/common/theme/app_color.dart';
import 'package:album_app/common/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButtonAuth extends StatelessWidget {
  final String title;
  final width;
  final VoidCallback onPressed;

  CustomButtonAuth({Key key, this.title, this.width, this.onPressed});
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: width,
        height: 45,
        decoration: BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            title, style: AppTextStyles.regularW500(context, size: 16,color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
