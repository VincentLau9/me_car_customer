import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:me_car_customer/app/api/user_api.dart';
import 'package:me_car_customer/app/base/base_controller.dart';
import 'package:me_car_customer/app/modules/start_app/controllers/start_app_controller.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/routes/app_pages.dart';

class PersonalInformationController extends BaseController {
  //TODO: Implement HomeController

  final count = 0.obs;
  final isLoading = true.obs;
  final email = ''.obs;
  final error = ''.obs;
  final name = ''.obs;
  // final errorName = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    email(Get.find<StartAppController>().email.value);
    name(Get.find<StartAppController>().name.value);

    // await UserApi.getProfile(Get.find<StartAppController>().userId.value);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setEmailData(String value) {
    if (GetUtils.isEmail(value)) {
      email(value);
      error('');
    } else {
      error('Sai định dạng email vd: abc@gmail.com');
    }
  }

  void setNameData(String value) {
    name(value);
  }

  bool validation() {
    if (name.value.isEmpty || error.isNotEmpty) {
      return false;
    } else {
      return true;
    }
  }

  updateInfomation() async {
    log(email.value);
    try {
      Get.dialog(
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Center(
                child: SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(
                color: ColorsManager.primary,
              ),
            )),
          ),
          barrierDismissible: true);
      if (!validation()) {
//thông báo thiếu thông tin
        log("f");
        Get.back();
      } else {
        if (await UserApi.updateInfomationV2(name.value,
            Get.find<StartAppController>().numberPhone.value, email.value)) {
          Get.find<StartAppController>().email(email.value);
          Get.find<StartAppController>().name(name.value);
          email(Get.find<StartAppController>().email.value);
          name(Get.find<StartAppController>().name.value);
          Get.back();
          Get.snackbar('Thông báo', 'Cập nhật thông tin thành công',
              backgroundColor: Colors.green.withOpacity(0.7),
              colorText: Colors.white);
        } else {}
      }
    } catch (e) {
      log(e.toString());
      Get.toNamed(Routes.SIGN_IN);
      Get.snackbar('Thông báo', 'Có gì đó không đúng');
    }
  }
}
