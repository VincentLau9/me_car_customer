import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_controller.dart';
import 'package:me_car_customer/app/base/base_view.dart';
import 'package:me_car_customer/app/model/service_filter.dart';
import 'package:me_car_customer/app/modules/common/components/form_field_widget.dart';
import 'package:me_car_customer/app/modules/pre-booking/controllers/pre_booking_controller.dart';
import 'package:me_car_customer/app/resources/assets_manager.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/resources/text_style.dart';

class Chooservice extends BaseView<PreBookingController> {
  Chooservice({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
            child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: context.width),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ColorsManager.primary),
                    padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                  ),
                  child: Text(
                    "Xong",
                    style: TextStyleConstant.white16Roboto,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ))),
        body: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  'Chọn dịch vụ',
                  style: TextStyleConstant.black22RobotoBold,
                )),
              ),
              Expanded(child: SizedBox())
            ],
          )),
          Expanded(
            flex: 9,
            child: Column(
              children: [
                // Expanded(
                //     child: Container(
                //   child: FormFieldWidget(
                //       isEnabled: false,
                //       padding: 10,
                //       icon: Icon(Icons.search),
                //       textInputType: TextInputType.text,
                //       labelText: "Tìm kiếm",
                //       setValueFunc: () {}),
                // )),
                Expanded(
                  flex: 7,
                  child: Obx(() {
                    controller.serChoose.value;
                    return GridView.builder(
                        itemCount: controller.listSerFilter.value.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.8,
                        ),
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          bool check = controller.serChoose
                              .contains(controller.listSerFilter.value[index]);
                          return itemService(
                              controller.listSerFilter[index], check);
                        });
                  }),
                ),
              ],
            ),
          )
        ])));
  }

  Container itemService(ServiceFilter service, bool isChoose) {
    return Container(
      padding: EdgeInsets.all(10),
      // height: UtilsReponsive.height(context, 120),
      // width:  UtilsReponsive.width(context, 50),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black)
          // color: Colors.red,
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: service.serviceImage != null &&
                      service.serviceImage!.isNotEmpty
                  ? Image.network(
                      service.serviceImage!,
                      fit: BoxFit.fill,
                      width: double.infinity,
                    )
                  : Image.asset(
                      ImageAssets.card,
                      fit: BoxFit.fill,
                      width: double.infinity,
                    )),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  service.serviceName ?? 'Null',
                  style: TextStyleConstant.black16RobotoBold,
                ),
                SizedBox(
                  height: 5,
                ),
                // Text(
                //   "Description",
                //   style: TextStyleConstant.black16Roboto,
                // ),
              ],
            ),
          ),
          Expanded(
              child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Đặt bán kính bo tròn cho viền
                  ),
                  side: BorderSide(
                    color: ColorsManager.primary, // Màu sắc viền
                    width: 2, // Độ dày viền
                  ),
                  backgroundColor:
                      isChoose ? ColorsManager.primary : Colors.white),
              child: Text(
                isChoose ? "Đã chọn" : 'Chọn',
                style: isChoose
                    ? TextStyleConstant.white14RobotoBold
                    : TextStyleConstant.primary14RobotoBold,
              ),
              onPressed: () {
                controller.chooseService(service);
              },
            ),
          ))
        ],
      ),
    );
  }
}
