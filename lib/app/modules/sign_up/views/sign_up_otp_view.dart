import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:me_car_customer/app/api/user_api.dart';
import 'package:me_car_customer/app/base/base_view.dart';
import 'package:me_car_customer/app/resources/assets_manager.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/resources/text_style.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../controllers/sign_up_controller.dart';

class SignUpOTPView extends BaseView<SignUpController> {
  const SignUpOTPView({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: UtilsReponsive.height(context, 20),
            horizontal: UtilsReponsive.height(context, 15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            Container(
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            'Kiểm tra email của bạn   ',
                            style: TextStyleConstant.primary22RobotoBold,
                          ),
                          Image.asset(ImageAssets.gmailIcon)
                        ],
                      ),
                    ),
                    Expanded(
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: RichText(
                            text: new TextSpan(
                              style: new TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                new TextSpan(
                                    text:
                                        'Chúng tôi đã gửi cho bạn số OTP gồm 6 chữ số vào số điện thoại của bạn '),
                                new TextSpan(
                                    text: controller.email.value,
                                    style:
                                        TextStyleConstant.primary14RobotoBold),
                              ],
                            ),
                          )),
                    )
                  ]),
            ),
            OtpTextField(
              borderRadius: BorderRadius.circular(10),
              focusedBorderColor: Color(0xFF5CB85C),
              fieldWidth: UtilsReponsive.height(context, 50),

              numberOfFields: 6,
              borderColor: Color(0xFF5CB85C),
              showFieldAsBox: true,
              onCodeChanged: (String code) {},
              onSubmit: (String verificationCode) async {
                await controller.checkOTP(verificationCode);
              }, // end onSubmit
            ),
            SizedBox(
              height: UtilsReponsive.height(context, 16),
            ),
            SizedBox(
              height: UtilsReponsive.height(context, 16),
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: context.width),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(ColorsManager.primary),
                  padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                ),
                child: Text(
                  "Tiếp tục",
                  style: TextStyleConstant.white16Roboto,
                ),
                onPressed: () async {
                  if (controller.enableButton.isTrue) {
                    // await controller.signUp();
                  }
                },
              ),
            ),
            SizedBox(
              height: UtilsReponsive.height(context, 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Đã nhận được mã OTP? '),
                TextButton(
                    onPressed: () async {
                      if (controller.countDown == 0) {
                        controller.countDownFunction();
                        await UserApi.sendOTP(controller.email.value);
                      }
                    },
                    child: Obx(
                      () => Text(
                        controller.countDown == 0
                            ? 'Gửi lại'
                            : 'Gửi lại sau 00:' +
                                '${controller.countDown.value < 10 ? '0' : ''}' +
                                '${controller.countDown}',
                        style: TextStyleConstant.primary16Roboto,
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
