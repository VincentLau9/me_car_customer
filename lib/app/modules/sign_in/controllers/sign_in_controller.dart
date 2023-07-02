
import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:me_car_customer/app/api/user_api.dart';
import 'package:me_car_customer/app/base/base_controller.dart';
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
  RxString email = "".obs;
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

  setValueEmail(String value) {
    email(value);
    if (!GetUtils.isEmail(value)) {
      errorEmailInput('Email không hợp lệ');
    } else {
      errorEmailInput("");
    }
    checkEnableButton();
  }

  checkEnableButton() {
    if (errorEmailInput.isEmpty &&
        errorPasswordInput.isEmpty &&
        email.isNotEmpty &&
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
      UserModel userLogin = await UserApi.login(email.value, passowrd.value);
      userLogin.password = passowrd.value;
      Box boxLogin = await Hive.openBox("userModel");
      await boxLogin.clear();
      await boxLogin.put('loginModel', userLogin);
      Get.find<StartAppController>().userModelT(userLogin);
      Get.snackbar('Thông báo', 'Đăng nhập thành công');
      if (userLogin.userFullName!.isEmpty) {
        Get.toNamed(Routes.UPDATE_FIRSTTIME);
      } else {
        Get.offAllNamed(Routes.HOME);
      }
      lockButton(false);
    } catch (e) {
      log(e.toString());
      //  Get.snackbar('Thông báo', 'Đăng nhập thất bại');
      lockButton(false);
    }
  }
}
