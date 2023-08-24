import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:me_car_customer/app/api/user_api.dart';
import 'package:me_car_customer/app/base/base_controller.dart';
import 'package:me_car_customer/app/data/database_local.dart';
import 'package:me_car_customer/app/routes/app_pages.dart';

class StartAppController extends BaseController {
  //TODO: Implement StartAppController

  Rx<String> token = ''.obs;
  String accessToken = '';
  Rx<String> name = ''.obs;
  Rx<String> numberPhone = ''.obs;
  Rx<String> email = ''.obs;
  // Rx<UserModel> userModelT = UserModel().obs;
  @override
  void onInit() async {
    super.onInit();
    await refeshToken();
    // userModelT.value = await getLoginModel();
  }

  @override
  Future<void> onReady() async {
    super.onReady();

  }

  @override
  void onClose() {
    super.onClose();
  }

  refeshToken() async {
    // Obtain shared preferences.
    String? refeshToken = await DatabaseLocal.instance.getRefeshToken();
    log(refeshToken.toString());
    if (refeshToken == null) {
      Get.offAllNamed(Routes.SIGN_IN);
    } else {
      //Goi refeshtokenapu
      dynamic response = await UserApi.refeshToken(refeshToken);
      log(response.body);
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        accessToken = data["userToken"];
        String refeshToken = data["refreshToken"]; 
        name(data["userFullName"] ?? "");
        numberPhone(data["userPhone"] ?? "");
        email(data["userEmail"]??"");
        await DatabaseLocal.instance.saveRefeshToken(refeshToken);
        if (name.value.trim().isEmpty) {
          Get.offAllNamed(Routes.UPDATE_FIRSTTIME);
        } else {
          Get.offAllNamed(Routes.HOME);
        }
      } else {
        Get.offAllNamed(Routes.SIGN_IN);
      }
    }
  }

  logout() async {
    await DatabaseLocal.instance.removeJwtToken();
    Get.offAllNamed(Routes.WELCOME_BOARD);
  }

  // login(UserModel userModel) async {
  //   try {
  //     String passowrd = userModel.password ?? "";
  //     UserModel userLogin = await UserApi.login(
  //         userModel.userEmail ?? "", userModel.password ?? "");
  //     Box boxLogin = await Hive.openBox("userModel");
  //     userLogin.password = passowrd;
  //     userModelT(userLogin);
  //     log(userModelT.value.userToken.toString());
  //     token(userLogin.userToken);
  //     await boxLogin.clear();
  //     await boxLogin.put('loginModel', userLogin);
  //     if (userLogin.userFullName!.isEmpty) {
  //       Get.offAllNamed(Routes.UPDATE_FIRSTTIME);
  //       Get.snackbar('Thông báo', 'Bạn chưa cập nhật một số thông tin');
  //     } else {
  //       Get.offAllNamed(Routes.HOME);
  //     }
  //   } catch (e) {
  //     log('err' + e.toString());
  //     Get.offAllNamed(Routes.SIGN_IN);
  //   }
  // }
}
