import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_car_customer/app/api/user_api.dart';
import 'package:me_car_customer/app/base/base_controller.dart';
import 'package:me_car_customer/app/data/database_local.dart';
import 'package:me_car_customer/app/model/user.dart';
import 'package:me_car_customer/app/modules/start_app/controllers/start_app_controller.dart';
import 'package:me_car_customer/app/routes/app_pages.dart';

class SignInController extends BaseController {
  //TODO: Implement SignInController

  final count = 0.obs;
  RxBool checkpassword = true.obs;
  RxBool enableButton = false.obs;
  RxString errorEmailInput = "".obs;
  RxString errorPasswordInput = "".obs;
  RxString phone = "".obs;
  RxString passowrd = "".obs;
  RxBool lockButton = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  setValuePhone(String value) {
    phone(value);
    // if (!GetUtils.isPhoneNumber(value) && value.length!=10) {
    //   errorEmailInput('Số điện thoại không hợp lệ');
    // } else {
    errorEmailInput("");
    // }
    checkEnableButton();
  }

  checkEnableButton() {
    if (errorEmailInput.isEmpty &&
        errorPasswordInput.isEmpty &&
        phone.trim().isNotEmpty &&
        passowrd.isNotEmpty) {
      enableButton(true);
    } else {
      enableButton(false);
    }
  }

  setValuePassword(String value) {
    passowrd(value);
    if (passowrd.isEmpty) {
      errorPasswordInput('Mật khẩu không được để trống');
    } else {
      errorPasswordInput('');
    }
    checkEnableButton();
  }

  login() async {
    try {
      lockButton(true);
      UserModel userLogin = await UserApi.login(phone.value, passowrd.value);
      Get.find<StartAppController>().accessToken = userLogin.userToken!;
      Get.find<StartAppController>().name.value = userLogin.userFullName!;
      Get.find<StartAppController>().numberPhone.value = userLogin.userPhone!;
      String refeshToken = userLogin.refreshToken ?? "";
      log("Login: $refeshToken");
      await DatabaseLocal.instance.saveRefeshToken(refeshToken);
      Get.snackbar('Thông báo', 'Đăng nhập thành công',
          backgroundColor: Colors.green.withOpacity(0.7),
          colorText: Colors.white);
      if (userLogin.userFullName!.isEmpty) {
        Get.offAllNamed(Routes.UPDATE_FIRSTTIME);
      } else {
        Get.offAllNamed(Routes.HOME);
      }
      lockButton(false);
    } catch (e) {
      log(e.toString());
      Get.snackbar('Thông báo', 'Đăng nhập thất bại', backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white);
      lockButton(false);
    }
  }
}
