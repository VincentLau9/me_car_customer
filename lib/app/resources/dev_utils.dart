import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DevUtils {
  static void printLog(String nameClass, String funcOrLine, String content) {
    dev.log(nameClass + "-" + funcOrLine + "-" + content);
  }

  static void showSnackbarMessage(String title, String content, Color color) {
    Get.snackbar(title, content,
        backgroundColor: color, colorText: Colors.white);
  }
}
