import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:me_car_customer/app/modules/start_app/controllers/start_app_controller.dart';
import 'package:me_car_customer/app/resources/assets_manager.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/resources/text_style.dart';
import 'package:me_car_customer/app/routes/app_pages.dart';

import '../../controllers/tab-profile-controller/tab_profile_controller.dart';

class TabProfileView extends GetView<TabProfileController> {
  const TabProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(ImageAssets.logo,
                            height: UtilsReponsive.height(context, 53),
                            width: UtilsReponsive.width(context, 53)),
                        Text(
                          'Hồ Sơ của bạn',
                          style: TextStyleConstant.black22RobotoBold,
                        ),
                      ],
                    ),
                    SizedBox()
                    // SvgPicture.asset('assets/images/icon_setting.svg')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child:
                        ClipOval(child: Image.asset("assets/images/user1.png"),)
                        ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        flex: 3,
                        child: Text(
                          Get.find<StartAppController>().name.value ?? "",
                          style: TextStyleConstant.black22RobotoBold,
                        ))
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    width: double.infinity,
                    height: 2,
                    color: Colors.grey.withOpacity(0.3)),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.PERSONAL_VIEW);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    height: UtilsReponsive.height(context, 60),
                    width: UtilsReponsive.width(context, 320),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.withOpacity(0.3))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/images/user.svg'),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Thông tin cá nhân',
                                style: TextStyleConstant.black16RobotoBold),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: ColorsManager.primary,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                        Get.toNamed(Routes.LIST_MYCAR, arguments: true);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    height: UtilsReponsive.height(context, 60),
                    width: UtilsReponsive.width(context, 320),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.withOpacity(0.3))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/images/car.svg'),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Thông tin xe của tôi',
                                style: TextStyleConstant.black16RobotoBold),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: ColorsManager.primary,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 12),
                //   height: UtilsReponsive.height(context, 60),
                //   width: UtilsReponsive.width(context, 320),
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(20),
                //       border: Border.all(color: Colors.grey.withOpacity(0.3))),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Row(
                //         children: [
                //           SvgPicture.asset('assets/images/clock.svg'),
                //           SizedBox(
                //             width: 10,
                //           ),
                //           Text('Lịch sử đặt lịch',
                //               style: TextStyleConstant.black16RobotoBold),
                //         ],
                //       ),
                //       Icon(
                //         Icons.arrow_forward,
                //         color: ColorsManager.primary,
                //       )
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () async {
                 await   Get.find<StartAppController>().logout();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    height: UtilsReponsive.height(context, 60),
                    width: UtilsReponsive.width(context, 320),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: Colors.grey.withOpacity(0.3))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/images/logout.svg'),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Đăng xuất',
                                style: TextStyleConstant.black16RobotoBold),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: ColorsManager.primary,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
