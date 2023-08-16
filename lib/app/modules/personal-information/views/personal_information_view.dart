import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_view.dart';
import 'package:me_car_customer/app/modules/start_app/controllers/start_app_controller.dart';
import 'package:me_car_customer/app/resources/assets_manager.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/resources/text_style.dart';

import '../controllers/personal_information_controller.dart';

class PersonalInformationView extends BaseView<PersonalInformationController> {
  const PersonalInformationView({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: UtilsReponsive.height(context, 15),
            )),
        title: Padding(
          padding: UtilsReponsive.paddingOnly(context, right: 55),
          child: Align(
              alignment: Alignment.center,
              child: Text(
                "Cập Nhật Tài Khoản",
                style: TextStyleConstant.black16RobotoBold,
              )),
        ),
      ),
      body: Material(
        child: Container(
          width: UtilsReponsive.width(context, 375),
          height: UtilsReponsive.height(context, 812),
          color: Colors.white,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                controller.isLoading.value == true ? SizedBox() : SizedBox(),
                Center(
                    child: ClipOval(
                        child: Image.asset('assets/images/user1.png',
                            fit: BoxFit.fill,
                            height: UtilsReponsive.height(context, 80),
                            width: UtilsReponsive.height(context, 80)))),
                Padding(
                  padding:
                      UtilsReponsive.paddingOnly(context, top: 30, left: 20),
                  child: Text(
                    "Họ & Tên",
                    style: TextStyleConstant.black16RobotoBold,
                  ),
                ),
                Padding(
                  padding: UtilsReponsive.paddingOnly(context,
                      top: 20, right: 20, left: 20),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    style: TextStyleConstant.black16Roboto,
                    cursorColor: ColorsManager.primary,
                    controller: null,
                    keyboardType: TextInputType.text,
                    validator: (value) {},
                    decoration: InputDecoration(
                      hintText: Get.find<StartAppController>().name.toString(),
                      hintStyle: TextStyleConstant.grey14Roboto,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.2), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.2), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                          width: 1,
                          color: ColorsManager.primary,
                        ),
                      ),
                      prefixIcon: ImageIcon(
                        AssetImage(IconAssets.icProfile),
                        size: UtilsReponsive.height(context, 30),
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      UtilsReponsive.paddingOnly(context, top: 30, left: 20),
                  child: Text(
                    "Email",
                    style: TextStyleConstant.black16RobotoBold,
                  ),
                ),
                Padding(
                  padding: UtilsReponsive.paddingOnly(context,
                      top: 20, right: 20, left: 20),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    style: TextStyleConstant.black16Roboto,
                    cursorColor: ColorsManager.primary,
                    controller: null,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {},
                    decoration: InputDecoration(
                      hintText: "nbac@gmail.com",
                      hintStyle: TextStyleConstant.grey14Roboto,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.2), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.2), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                          width: 1,
                          color: ColorsManager.primary,
                        ),
                      ),
                      prefixIcon: ImageIcon(
                        AssetImage(IconAssets.icMessage),
                        size: UtilsReponsive.height(context, 30),
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      UtilsReponsive.paddingOnly(context, top: 30, left: 20),
                  child: Text(
                    "Số Điện Thoại",
                    style: TextStyleConstant.black16RobotoBold,
                  ),
                ),
                Padding(
                  padding: UtilsReponsive.paddingOnly(context,
                      top: 20, right: 20, left: 20),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    style: TextStyleConstant.black16Roboto,
                    cursorColor: ColorsManager.primary,
                    controller: null,
                    keyboardType: TextInputType.phone,
                    validator: (value) {},
                    decoration: InputDecoration(
                      hintText:
                          Get.find<StartAppController>().numberPhone.toString(),
                      hintStyle: TextStyleConstant.grey14Roboto,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.2), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.2), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                          width: 1,
                          color: ColorsManager.primary,
                        ),
                      ),
                      prefixIcon: ImageIcon(
                        AssetImage(IconAssets.icPhone),
                        size: UtilsReponsive.height(context, 30),
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding:
                //       UtilsReponsive.paddingOnly(context, top: 30, left: 20),
                //   child: Text(
                //     "Mật khẩu",
                //     style: TextStyleConstant.black16RobotoBold,
                //   ),
                // ),
                // Padding(
                //   padding:
                //       UtilsReponsive.paddingOnly(context, top: 20, left: 20),
                //   child: Text(
                //     "Đổi mật khẩu",
                //     style: TextStyleConstant.primary16RobotoBold,
                //   ),
                // ),
                Padding(
                  padding: UtilsReponsive.paddingOnly(context,
                      top: 50, left: 20, right: 20, bottom: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      padding: UtilsReponsive.paddingOnly(context,
                          top: 15, bottom: 15),
                    ),

                    // ignore: sort_child_properties_last
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Lưu Thay Đổi',
                        textAlign: TextAlign.center,
                        style: TextStyleConstant.white16Roboto,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
