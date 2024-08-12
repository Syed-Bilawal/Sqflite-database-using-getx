import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AppUtils {

  static void showSuccessToast(String message) {
    Get.snackbar('Success', message,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

  static void showErrorToast(/* BuildContext context, */ String message) {
    Get.snackbar('Fail', message,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

  static void showLoading({Color? color}) {
    Get.dialog(
      barrierDismissible: false,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: color,
          ),
        ],
      ),
    );
  }

  static hideLoading() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

}
