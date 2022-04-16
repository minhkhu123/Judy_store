import 'package:album_app/common/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextFieldLogin extends StatefulWidget {
  final String title;
  final TextEditingController textEditingController;
  final VoidCallback onPressed;
  final bool isPassword;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;
  final SvgPicture iconData;
  final String backColor;
  final SvgPicture iconPre;
  final String hintText;
  final String error;

  const CustomTextFieldLogin({Key key,
    this.title,
    this.isPassword,
    this.keyboardType,
    this.backColor,
    this.iconData,
    this.onChanged,
    this.textEditingController,
    this.iconPre,
    this.hintText,
    this.error,
    this.onPressed});

  @override
  _CustomTextFieldLoginState createState() => _CustomTextFieldLoginState();
}

class _CustomTextFieldLoginState extends State<CustomTextFieldLogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        obscureText: !widget.isPassword,
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
          suffixIcon: IconButton(
            icon: widget.iconData,
            onPressed: widget.onPressed,
          ),
          prefixIcon: IconButton(
            icon: widget.iconPre,
          ),
          errorText: widget.error,
        ),
      ),
    );
  }
}
