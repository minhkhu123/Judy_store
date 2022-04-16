import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MoneyUtil {
  static NumberFormat getMoneyFormat() {
    return NumberFormat("#,###");
  }

  static String moneyFormat(dynamic number) {
    return getMoneyFormat().format(number);
  }

  static List<String> convertNumToMoney(int num) {
    String b = "$num";
    String c = b;
    var a = new List(20);

    String value = "";
    String unit = "";

    int dem = b.length;
    for (int i = 0; i < dem; i++) {
      a[dem - 1 - i] = int.parse(b[i]);
    }

    if (dem <= 3) {
      for (int i = 0; i <= dem - 1; i++) {
        value += c[i];
      }
      unit = "đ";
    } else if (dem <= 6) {
      for (int i = dem - 1; i > 1; i--) {
        value += i == 2 ? ".${a[i]}" : "${a[i]}";
      }
      unit = "K";
    } else if (dem <= 9) {
      for (int i = dem - 1; i > 4; i--) {
        value += i == 5 ? ".${a[i]}" : "${a[i]}";
      }
      unit = "tr";
    } else {
      for (int i = dem - 1; i > 7; i--) {
        value += i == 8 ? ".${a[i]}" : "${a[i]}";
      }
      unit = "M";
    }
    return [value, unit];
  }

  static String getMoneyDisplay(int num, {String space = ""}) {
    List<String> list = convertNumToMoney(num);
    return "${list[0]}$space ${list[1]}";
  }
}