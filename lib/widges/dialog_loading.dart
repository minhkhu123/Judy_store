import 'package:album_app/common/theme/app_color.dart';
import 'package:album_app/common/theme/app_dimens.dart';
import 'package:album_app/common/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class DialogLoading extends StatelessWidget {
  const DialogLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: AppDimens.space100),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Container(
        height: height * 0.12,
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: CircularProgressIndicator(
                backgroundColor: AppColors.white,
              ),
            ),
            SizedBox(
              height: AppDimens.padding16,
            ),
            Text(
              'Loading...',
              style: AppTextStyles.regularW500(context, size: AppDimens.textSize12, color: AppColors.blue),
            )
          ],
        ),
      ),
    );
  }
}