import 'package:album_app/common/theme/app_color.dart';
import 'package:album_app/common/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextFieldCreateInfo extends StatefulWidget {
  final String title;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;
  final String hintText;
  final String error;
  final String surfix;
  final List<TextInputFormatter> inputFormatters;

  const CustomTextFieldCreateInfo({Key key,
    this.title,
    this.keyboardType,
    this.onChanged,
    this.textEditingController,
    this.hintText,
    this.error,
    this.surfix,
    this.inputFormatters
  });

  @override
  _CustomTextFieldCreateInfoState createState() => _CustomTextFieldCreateInfoState();
}

class _CustomTextFieldCreateInfoState extends State<CustomTextFieldCreateInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        onChanged: (value) {
          if (widget.onChanged != null) widget.onChanged(value);
        },
        keyboardType: widget.keyboardType,
        controller: widget.textEditingController,
        style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color: AppColors.hintText),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: AppColors.hintText),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
          isDense: true,
          suffixText: widget.surfix,
          suffixStyle: AppTextStyles.regularW500(context, size: 16,color: AppColors.black),
          errorText: widget.error,
        ),
        inputFormatters: widget.inputFormatters,
      ),
    );
  }
}
