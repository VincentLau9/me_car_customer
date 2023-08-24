import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_view.dart';
import 'package:me_car_customer/app/model/garage.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/resources/text_style.dart';
import 'package:me_car_customer/app/routes/app_pages.dart';

import '../controllers/garage_detail_controller.dart';

class GarageDetailView extends BaseView<GarageDetailController> {
  const GarageDetailView({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    //  double km= (Geolocator.distanceBetween(garageModel.garageLatitude!,garageModel.garageLongitude!,10.841823064481721, 106.80984008465619)/1000).toPrecision(1);
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.value
              ? Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      // height: UtilsReponsive.height(context, 100),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: Icon(Icons.arrow_back))),
                          Expanded(
                              flex: 3,
                              child: Center(
                                  child: Text(
                                controller.data.value.garageName ?? "",
                                style: TextStyleConstant.black22RobotoBold,
                                textAlign: TextAlign.center,
                              ))),
                          Expanded(child: SizedBox())
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(controller.data.value.rating.toString()),
                        SvgPicture.asset('assets/images/star.svg'),
                        Text(' |  ${controller.data.value.garageDistrict}')
                      ],
                    ),
                    SizedBox(
                      height: UtilsReponsive.height(context, 15),
                    ),
                    Container(
                      padding:
                          EdgeInsets.all(UtilsReponsive.height(context, 15)),
                      height: UtilsReponsive.height(context, 430),
                      width: UtilsReponsive.width(context, 320),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey)),
                      child: Column(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/location_icon.svg'),
                                  SizedBox(
                                    width: UtilsReponsive.width(context, 10),
                                    height: UtilsReponsive.height(context, 25),
                                  ),
                                  Text(
                                    'Địa điểm',
                                    style: TextStyleConstant.black16RobotoBold,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: UtilsReponsive.height(context, 10),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: UtilsReponsive.width(context, 25)),
                                child: Text(
                                  controller.data.value.garageFullAddress ?? "",
                                ),
                              ),
                            ],
                          )),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/location_icon.svg'),
                                  SizedBox(
                                    width: UtilsReponsive.width(context, 10),
                                    height: UtilsReponsive.height(context, 25),
                                  ),
                                  Text(
                                    'Khoảng cách',
                                    style: TextStyleConstant.black16RobotoBold,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: UtilsReponsive.height(context, 10),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: UtilsReponsive.width(context, 25)),
                                child: Text(
                                  controller.data.value.km! > 0
                                      ? controller.data.value.km.toString() +
                                          ' km'
                                      : "Chưa xác định",
                                ),
                              ),
                            ],
                          )),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/location_icon.svg'),
                                  SizedBox(
                                    width: UtilsReponsive.width(context, 10),
                                    height: UtilsReponsive.height(context, 25),
                                  ),
                                  Text(
                                    'Thời gian làm việc',
                                    style: TextStyleConstant.black16RobotoBold,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: UtilsReponsive.height(context, 10),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: UtilsReponsive.width(context, 25)),
                                child: Text(
                                  controller.data.value.hoursOfOperation ?? "",
                                ),
                              ),
                            ],
                          )),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/location_icon.svg'),
                                  SizedBox(
                                    width: UtilsReponsive.width(context, 10),
                                    height: UtilsReponsive.height(context, 20),
                                  ),
                                  Text(
                                    'Số điện thoại',
                                    style: TextStyleConstant.black16RobotoBold,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: UtilsReponsive.height(context, 10),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: UtilsReponsive.width(context, 25)),
                                child: Text(
                                  controller
                                      .data.value.managerGarageDto!.userPhone
                                      .toString(),
                                ),
                              ),
                            ],
                          )),
                          Container(
                            height: UtilsReponsive.height(context, 32),
                            width: UtilsReponsive.width(context, 280),
                            child: ConstrainedBox(
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
                                      ColorsManager.primary),
                                  // padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                                ),
                                child: Text(
                                  "Đặt dịch vụ",
                                  style: TextStyleConstant.white16Roboto,
                                ),
                                onPressed: () async {
                                  Get.offNamed(Routes.BOOKING_STEP,
                                      arguments: GarageModel(
                                          garageId:
                                              controller.data.value.garageId,
                                          garageName:
                                              controller.data.value.garageName,
                                          garageAddress: controller
                                              .data.value.garageAddress));
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
