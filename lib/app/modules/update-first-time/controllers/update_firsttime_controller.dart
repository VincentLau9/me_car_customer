import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_car_customer/app/api/car_api.dart';
import 'package:me_car_customer/app/api/user_api.dart';
import 'package:me_car_customer/app/base/base_controller.dart';
import 'package:me_car_customer/app/model/car.dart';
import 'package:me_car_customer/app/model/user.dart';
import 'package:me_car_customer/app/modules/start_app/controllers/start_app_controller.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/routes/app_pages.dart';

class UpdateFirstTimeController extends BaseController {
  //TODO: Implement UpdateFirsttimeController

  RxInt indexPage = 0.obs;
  PageController pageController = PageController();
  RxString phoneNumber = ''.obs;
  RxString name = ''.obs;
  RxString errPhoneInput = ''.obs;
  RxString errNameInput = ''.obs;
  RxString email = ''.obs;
  RxList<Car> listCar = <Car>[].obs;
  @override
  void onInit() async {
    super.onInit();
    // await getEmail();
    await loadAllCar();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void jumpToPage() {
    checkValidation();
    if (indexPage.value + 1 < 3 &&
        errNameInput.isEmpty) {
      indexPage++;
      pageController.animateToPage(indexPage.value,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  // getEmail() async {
  //   Box boxLogin = await Hive.openBox("userModel");
  //   if (boxLogin.values.isNotEmpty) {
  //     log('logign');
  //     UserModel userModel = await boxLogin.getAt(0) as UserModel;
  //     email.value = userModel.userEmail!;
  //     log('logign ${email}');
  //   } else {
  //     Get.offAllNamed(Routes.SIGN_IN);
  //   }
  // }

  void changePage(int value) {
    checkValidation();
    indexPage.value = value;
  }

  void onTapChangePage(int value) {
    checkValidation();
    if (errNameInput.isEmpty && errPhoneInput.isEmpty) {
      pageController.animateToPage(value,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  void setValueName(String value) {
    name(value);
    checkValidation();
  }

  void setValuePhone(String value) {
    phoneNumber(value);
    checkValidation();
  }

  checkValidation() {
    if (name.trim().isEmpty) {
      errNameInput('Tên không được bỏ trống');
    } else {
      errNameInput('');
    }
  }

  loadAllCar() async {
    listCar.value = await CarApi.loadAllCar();
  }

  updateInfomation() async {
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
      ),barrierDismissible: true);
      if (await UserApi.updateInfomation(name.value, phoneNumber.value)) {
        Get.find<StartAppController>().name.value=name.value;
        Get.toNamed(Routes.HOME);
      } else {
        Get.toNamed(Routes.SIGN_IN);
        Get.snackbar('Thông báo', 'Có gì đó không đúng');
      }
    } catch (e) {
      log(e.toString());
      Get.toNamed(Routes.SIGN_IN);
      Get.snackbar('Thông báo', 'Có gì đó không đúng');
    }
  }
}
