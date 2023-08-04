import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_view.dart';
import 'package:me_car_customer/app/modules/pre-booking/views/choose_service_screen.dart';
import 'package:me_car_customer/app/modules/pre-booking/views/search_address_screen.dart';
import 'package:me_car_customer/app/resources/assets_manager.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/resources/text_style.dart';

import '../controllers/pre_booking_controller.dart';

class PreBookingView extends BaseView<PreBookingController> {
  const PreBookingView({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Obx(() => ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: context.width),
              child: ElevatedButton(
                style: ButtonStyle(
                  // shape: MaterialStateProperty.all(
                  //   RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  // ),
                  backgroundColor: MaterialStateProperty.all(
                      controller.isLockButton.value
                          ? Colors.grey
                          : ColorsManager.primary),
                  padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                ),
                child: Text(
                  "Tìm ngay",
                  style: TextStyleConstant.white16Roboto,
                ),
                onPressed: () async {
                  await controller.searchGarageByFiler();
                },
              ),
            )),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Row(
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(
                        child: Text(
                      'Thời gian và địa điểm',
                      style: TextStyleConstant.black22RobotoBold,
                    )),
                  ),
                  Expanded(child: SizedBox())
                ],
              )),
              Expanded(
                  flex: 9,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Địa điểm",
                            style: TextStyleConstant.black16RobotoBold,
                          ),
                          GestureDetector(
                            onTap: () => Get.to(SearchAddressPreBooking()),
                            child: TextFormField(
                              controller: controller.txtLocation,
                              enabled: false,
                              decoration: InputDecoration(
                                  hintText: 'Chọn địa chỉ',
                                  icon: SvgPicture.asset(
                                    IconAssets.location_icon,
                                    height: 20,
                                    width: 20,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Thời gian",
                            style: TextStyleConstant.black16RobotoBold,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.showChooseDate();
                            },
                            child: TextFormField(
                              controller: controller.txtDate,
                              enabled: false,
                              decoration: InputDecoration(
                                  icon: SvgPicture.asset(
                                IconAssets.time_icon,
                                height: 20,
                                width: 20,
                              )),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Text(
                          //   "Loại xe",
                          //   style: TextStyleConstant.black16RobotoBold,
                          // ),
                          // Container(
                          //     margin: EdgeInsets.only(top: 10),
                          //     width: double.infinity,
                          //     padding: EdgeInsets.all(8),
                          //     height: UtilsReponsive.height(context, 90),
                          //     // decoration: BoxDecoration(
                          //     //     border: Border(
                          //     //         bottom: BorderSide(color: Colors.black),
                          //     //         top: BorderSide(color: Colors.black))),
                          //     child: Obx(
                          //       () => controller.numberChoose.value == -1
                          //           ? SizedBox()
                          //           : ListView.separated(
                          //               scrollDirection: Axis.horizontal,
                          //               shrinkWrap: true,
                          //               itemCount: controller.listNumber.length,
                          //               separatorBuilder: (context, index) =>
                          //                   SizedBox(
                          //                 width: 5,
                          //               ),
                          //               itemBuilder: (context, index) =>
                          //                   GestureDetector(
                          //                 onTap: () {
                          //                   controller.numberChoose.value =
                          //                       controller.listNumber[index];
                          //                 },
                          //                 child: Column(
                          //                   mainAxisSize: MainAxisSize.min,
                          //                   children: [
                          //                     Expanded(
                          //                       flex: 2,
                          //                       child: CircleAvatar(
                          //                         backgroundColor:
                          //                             controller.listNumber[
                          //                                         index] ==
                          //                                     controller
                          //                                         .numberChoose
                          //                                         .value
                          //                                 ? Colors.greenAccent
                          //                                     .shade100
                          //                                 : Colors.white38,
                          //                         radius: UtilsReponsive.height(
                          //                             context, 50),
                          //                         child: SvgPicture.asset(
                          //                           'assets/images/car.svg',
                          //                           fit: BoxFit.fill,
                          //                           height: 30,
                          //                           width: 30,
                          //                         ),
                          //                       ),
                          //                     ),
                          //                     Text(
                          //                         '${controller.listNumber[index]} - chỗ')
                          //                   ],
                          //                 ),
                          //               ),
                          //             ),
                          //     )
                          //     ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Dịch vụ",
                            style: TextStyleConstant.black16RobotoBold,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: UtilsReponsive.width(context, 70)),
                            child: Obx(() => ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(
                                      width: context.width),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all(controller
                                                      .serChoose
                                                      .value
                                                      .isNotEmpty 
                                              ? ColorsManager.primary
                                              : Colors.grey),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.all(14)),
                                    ),
                                    child: Text(
                                      controller.serChoose .value
                                                      .isNotEmpty ?"${ controller.serChoose .value
                                                      .length} dịch vụ đã chọn":
                                          "Chọn dịch vụ",
                                      style: TextStyleConstant.white16Roboto,
                                    ),
                                    onPressed: () async {
                                      Get.to(Chooservice());
                                    },
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }
}
