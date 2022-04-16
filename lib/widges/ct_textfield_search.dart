import 'package:album_app/common/images.dart';
import 'package:album_app/common/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSearchTextField extends StatelessWidget {
  final controller;
  final bool readOnly;
  final ValueChanged<String> onChanged;
  final TextEditingController textEditingController;
  final VoidCallback onPressed;
  final VoidCallback onTapTextField;

  const CustomSearchTextField({Key key, this.controller, this.onChanged, this.textEditingController, this.onPressed, this.onTapTextField, this
      .readOnly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.06,
      width: width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.searchBG,
      ),
      child: TextField(
        readOnly: readOnly,
        onTap: onTapTextField,
        onChanged: (value) {
          if (onChanged != null) onChanged(value);
        },
        controller: textEditingController,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(5),
            filled: true,
            hintText: ('Tìm kiếm...'),
            hintStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.searchHint),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
            ),
            prefixIcon: GestureDetector(
              onTap: onPressed,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: SvgPicture.asset(
                  Images.ic_search,
                  color: AppColors.searchHint,
                  height: 16,
                  width: 16,
                ),
              ),
            )),
      ),
    );
  }
}
