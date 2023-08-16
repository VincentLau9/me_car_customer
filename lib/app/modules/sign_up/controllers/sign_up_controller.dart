import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:me_car_customer/app/api/user_api.dart';
import 'package:me_car_customer/app/base/base_controller.dart';
import 'package:me_car_customer/app/modules/sign_up/views/sign_up_otp_view.dart';
import 'package:me_car_customer/app/routes/app_pages.dart';

class SignUpController extends BaseController {
  //TODO: Implement SignUpController

  final count = 0.obs;
  RxBool checkpassword = true.obs;
  RxBool enableButton = false.obs;
  RxString errorEmailInput = "".obs;
  RxString errorPasswordInput = "".obs;
  RxString email = "".obs;
  RxString passowrd = "".obs;
  RxString reTypePassowrd = "".obs;
  RxBool lockButton = false.obs;
  RxInt countDown = 59.obs;

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

  countDownFunction() {
    countDown(59);
    Timer.periodic(
        Duration(seconds: 1),
        (Timer timer) => {
              if (countDown == 0)
                {
                  timer.cancel(),
                }
              else
                {
                  countDown--,
                  print('$count'),
                }
            });
  }

  setValueEmail(String value) {
    email(value);
    if (!GetUtils.isPhoneNumber(value)) {
      errorEmailInput('Số điện thoại không hợp lệ');
    } else {
      errorEmailInput("");
    }
    checkEnableButton();
  }

  setValuePassword(String value) {
    passowrd(value);
    if (passowrd.isEmpty) {
      errorPasswordInput('Mật khẩu không được để trống');
    } else if (passowrd != reTypePassowrd) {
      errorPasswordInput('Mật khẩu nhập lại phải trùng');
    } else {
      errorPasswordInput('');
    }
    checkEnableButton();
  }

  setValueReTypePassword(String value) {
    reTypePassowrd(value);
    if (reTypePassowrd.isEmpty) {
      errorPasswordInput('Nhập lại mật khẩu');
    } else if (passowrd != reTypePassowrd) {
      errorPasswordInput('Mật khẩu nhập lại phải trùng');
    } else {
      errorPasswordInput('');
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

  register() async {
    lockButton(true);
    bool check = await UserApi.register(email.value, passowrd.value);
    if (check) {
      if (await UserApi.sendOTP(email.value)) {
        Get.to(SignUpOTPView());
        countDownFunction();
      } else {
        Get.snackbar('Lỗi', 'Vui lòng thử lại sau');
      }
    } else {
      Get.snackbar('Lỗi', 'Đăng kí thất bại');
    }
    lockButton(false);
  }

  checkOTP(String value) async {
    lockButton(true);
    try {
      if (await UserApi.checkOTP(email.value, value)) {
        Get.offAllNamed(Routes.SIGN_IN);
        Get.snackbar('Thông báo', 'Xác thực thành công');
      } else {
        Get.snackbar('Lỗi', 'Xác thực thất bại');
      }
    } catch (e) {
      log('checkOTP-' + e.toString());
    }
    lockButton(false);
  }
}
