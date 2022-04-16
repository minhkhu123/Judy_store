
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sp_util/sp_util.dart';

class Utils {
  static String getPhoneVn(String phone) {
    if (phone.startsWith("+84")) phone = phone.replaceFirst("+84", "0");
    return phone;
  }

  static showToast(String message, {Toast toastLength}) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: message,
        textColor: Colors.white,
        backgroundColor: Colors.grey[600],
        gravity: ToastGravity.BOTTOM,
        toastLength: toastLength ?? Toast.LENGTH_SHORT);
  }

  var convert8 = NumberFormat('###,###,###,###,###,###.00000000#', 'en_US');
  var convert2 = NumberFormat('###,###,###,###,###,###.00#', 'en_US');

  // String checkValidSalary() {
  //   if (salaryWant == "" && checkDeal.value) {
  //     return 'Bạn chưa nhập mức lương mong muốn';
  //   } else if (RegExp(r'^[.-]?').hasMatch(salaryWant) && salaryWant.isNotEmpty) {
  //     return 'Bạn nhập sai định dạng lương';
  //   }
  //   return null;
  // }

  static String checkValidPhone(String str) {
    if (str.isEmpty) {
      return 'Bạn chưa nhập số điện thoại';
    } else if (!RegExp(r'^((0[0-9])|(84[0-9]))\d{8,10}$').hasMatch(str) && str.isNotEmpty) {
      return 'Bạn nhập sai định dạng số điện thoại';
    }
    return null;
  }

  static String checkValidEmail(String str) {
    if (!RegExp(r'^[a-z0-9.]*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?').hasMatch(str) && str.isNotEmpty) {
      return 'Email bạn nhập không hợp lệ';
    } else if (str.isEmpty) {
      return 'Bạn chưa nhập Email';
    }
    return null;
  }

  static popLastScreen({@required int popCount, dynamic toScreen}) async{
    int count = 0;
    while(count < popCount){
      Get.back();
      count++;
    }
    if(toScreen != null) {
      await Future.delayed(Duration(milliseconds: 350));
      Get.to(toScreen);
    }
  }

}