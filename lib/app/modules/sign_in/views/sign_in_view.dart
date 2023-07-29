import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:me_car_customer/app/base/base_view.dart';
import 'package:me_car_customer/app/modules/common/components/form_field_widget.dart';
import 'package:me_car_customer/app/modules/home/views/home_view.dart';
import 'package:me_car_customer/app/resources/assets_manager.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/text_style.dart';
import 'package:me_car_customer/app/routes/app_pages.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends BaseView<SignInController> {
  const SignInView({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          width: context.width,
          height: context.height,
          child: SingleChildScrollView(
            child: Form(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 250,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Center(
                              child: Image(
                                image: AssetImage(ImageAssets.logo),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              right: 0,
                              left: 0,
                              child: Center(
                                child: Text(
                                  "MeCar",
                                  // LocaleKeys.login_page_text_title_form.tr,
                                  style: TextStyleConstant.black40RobotoBold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Tài khoản Email',
                      style: TextStyleConstant.primary16RobotoBold,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Obx(
                      () => FormFieldWidget(
                          padding: 10,
                          // initValue: controller.nameInput.value,
                          textInputType: TextInputType.number,
                          labelText: "Nhập email",
                          errorText: "${controller.errorEmailInput}",
                          setValueFunc: controller.setValueEmail),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text('Mật khẩu',
                        style: TextStyleConstant.primary16RobotoBold),
                    SizedBox(
                      height: 5,
                    ),
                    Obx(
                      () => FormFieldWidget(
                          padding: 10,
                          enableInteractiveSelection: false,
                          isObscureText: controller.checkpassword.value,
                          suffixIcon: IconButton(
                            icon: Icon(controller.checkpassword.value
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              controller.checkpassword.value =
                                  !controller.checkpassword.value;
                            },
                          ),
                          textInputType: TextInputType.text,
                          labelText: "Nhập mật khẩu",
                          errorText: "${controller.errorPasswordInput}",
                          setValueFunc: controller.setValuePassword),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'Quên mật khẩu?',
                          style: TextStyleConstant.primary14Roboto,
                        )),
                    SizedBox(
                      height: 16,
                    ),
                    Obx(
                      () => ConstrainedBox(
                        constraints:
                            BoxConstraints.tightFor(width: context.width),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                controller.enableButton.isTrue
                                    ? ColorsManager.primary
                                    : Colors.grey),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(14)),
                          ),
                          child: Obx(
                            () => controller.lockButton.value
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Đăng nhập",
                                    style: TextStyleConstant.white16Roboto,
                                  ),
                          ),
                          onPressed: () async {
                            if (controller.enableButton.isTrue&&controller.lockButton.isFalse) {
                              controller.login();
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 26,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text('Hoặc'),
                        ),
                        Expanded(
                            child: Divider(
                          color: Colors.grey,
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(ImageAssets.googleIcon),
                        SizedBox(
                          width: 20,
                        ),
                        Image.asset(ImageAssets.phoneIcon)
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Chưa có tài khoản?'),
                        TextButton(
                          child: Text(
                            '  Đăng ký',
                            style: TextStyleConstant.primary14RobotoBold,
                          ),
                          onPressed: () {
                            Get.toNamed(Routes.SIGN_UP);
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
