import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:me_car_customer/app/api/user_api.dart';
import 'package:me_car_customer/app/base/base_controller.dart';
import 'package:me_car_customer/app/model/user.dart';
import 'package:me_car_customer/app/routes/app_pages.dart';

class StartAppController extends BaseController {
  //TODO: Implement StartAppController

  Rx<String> token = ''.obs;
  Rx<UserModel> userModelT = UserModel().obs;
  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(
      Duration(seconds: 3),
    );
    userModelT.value = await getLoginModel();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<UserModel> getLoginModel() async {
    log('message');
    UserModel rs = UserModel();
    try {
      Box boxLogin = await Hive.openBox("userModel");
      if (boxLogin.values.isNotEmpty) {
        rs = await boxLogin.getAt(0) as UserModel;
        await login(rs);
      } else {
        Get.offAllNamed(Routes.WELCOME_BOARD);
      }
    } catch (e) {}
    return Future<UserModel>.value(rs);
  }

  login(UserModel userModel) async {
    try {
      String passowrd = userModel.password ?? "";
      UserModel userLogin = await UserApi.login(
          userModel.userEmail ?? "", userModel.password ?? "");
      Box boxLogin = await Hive.openBox("userModel");
      userLogin.password = passowrd;
      userModelT(userLogin);
      log(userModelT.value.userToken.toString());
      token(userLogin.userToken);
      await boxLogin.clear();
      await boxLogin.put('loginModel', userLogin);
      if (userLogin.userFullName!.isEmpty) {
        Get.offAllNamed(Routes.UPDATE_FIRSTTIME);
        Get.snackbar('Thông báo', 'Bạn chưa cập nhật một số thông tin');
      } else {
        Get.offAllNamed(Routes.HOME);
      }
    } catch (e) {
      log('err' + e.toString());
      Get.offAllNamed(Routes.SIGN_IN);
    }
  }
}
