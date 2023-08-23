import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:me_car_customer/app/api/garage_api.dart';
import 'package:me_car_customer/app/base/base_view.dart';
import 'package:me_car_customer/app/model/car.dart';
import 'package:me_car_customer/app/model/service_garage.dart';
import 'package:me_car_customer/app/model/staff.dart';
import 'package:me_car_customer/app/modules/common/components/form_field_widget.dart';
import 'package:me_car_customer/app/resources/assets_manager.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/resources/text_style.dart';
import 'package:me_car_customer/app/routes/app_pages.dart';

import '../controllers/booking_step_controller.dart';

class BookingStepView extends BaseView<BookingStepController> {
  const BookingStepView({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _bottomNavigaBar(context),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        height: UtilsReponsive.height(context, 70),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: IconButton(
                                    onPressed: () {
                                      // Get.back();
                                      if (controller.indexPage.value != 0) {
                                        controller.onTapChangePage(
                                            controller.indexPage.value - 1);
                                      } else {
                                        Get.back();
                                      }
                                    },
                                    icon: Icon(Icons.arrow_back))),
                            Expanded(
                              flex: 3,
                              child: _headerStep(),
                            ),
                            Expanded(
                                child: IconButton(
                                    onPressed: () async {
                                      Get.offAllNamed(Routes.HOME);
                                    },
                                    icon: Icon(Icons.home)))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 9,
                        child: PageView(
                          physics: NeverScrollableScrollPhysics(),
                          onPageChanged: (value) async {
                            await controller.changePage(value);
                          },
                          controller: controller.pageController,
                          children: [
                            _page1(context),
                            Obx(() => controller.isRefeshService.value
                                ? Center(
                                    child: SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : _page2(context)),
                            _page3(context),
                            _page4(context),
                          ],
                        ))
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget _bottomNavigaBar(BuildContext context) {
    return Obx(() => controller.indexPage == 3
        ? Container(
            margin: EdgeInsets.only(bottom: UtilsReponsive.height(context, 5)),
            padding: EdgeInsets.symmetric(
                horizontal: UtilsReponsive.width(context, 30)),
            width: double.infinity,
            height: UtilsReponsive.height(context, 120),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Tổng tiền',
                        style: TextStyleConstant.black22RobotoBold,
                      ),
                    ),
                    Expanded(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: Text('${controller.totalPrice.value}',
                          style: TextStyleConstant.primary22RobotoBold),
                    ))
                  ],
                ),
                SizedBox(
                  height: UtilsReponsive.height(context, 20),
                ),
                Container(
                  width: double.infinity,
                  height: UtilsReponsive.height(context, 50),
                  child: ElevatedButton(
                      onPressed: () async {
                        await controller.createBooking();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        textStyle: TextStyle(),
                      ),
                      child: Text("Xác nhận đặt lịch",
                          style: TextStyleConstant.white16Roboto)),
                ),
              ],
            ),
          )
        : Container(
            margin: EdgeInsets.only(bottom: UtilsReponsive.height(context, 5)),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            width: double.infinity,
            height: UtilsReponsive.height(context, 50),
            child: ElevatedButton(
                onPressed: () {
                  controller.jumpToPage();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.isEnableButton.value
                      ? ColorsManager.primary
                      : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  textStyle: TextStyle(),
                ),
                child:
                    Text("Tiếp theo", style: TextStyleConstant.white16Roboto)),
          ));
  }

  Container _page3(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: UtilsReponsive.width(context, 30),
          vertical: UtilsReponsive.height(context, 30)),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: UtilsReponsive.width(context, 30),
            ),
            child: Text(
              "Bạn có thể chọn một thợ để sửa chữa chiếc xe của bạn",
              textAlign: TextAlign.center,
              style: TextStyleConstant.black16Roboto,
            ),
          ),
          SizedBox(
            height: UtilsReponsive.height(context, 30),
          ),
          Container(
            padding: EdgeInsets.all(UtilsReponsive.height(context, 15)),
            // height: UtilsReponsive.height(context, 130),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorsManager.primary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Obx(() => controller.staffChoose.value.mechanicId == 0
                  ? Row(
                      children: [
                        Radio(
                            activeColor: ColorsManager.primary,
                            value: "Không chỉ định",
                            groupValue: "Không chỉ định",
                            onChanged: (String? value) {}),
                        Text(
                          'Không chỉ định',
                          style: TextStyleConstant.black16RobotoBold,
                        ),
                      ],
                    )
                  : ListTile(
                      leading: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              height: UtilsReponsive.height(Get.context!, 80),
                              width: UtilsReponsive.height(Get.context!, 80),
                              imageUrl: controller.staffChoose.value.image!,
                              errorWidget: (context, url, error) => Image.asset(
                                ImageAssets.card,
                                fit: BoxFit.fill,
                              ),
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                          radius: 40,
                        ),
                      ),
                      title: Text(
                        controller.staffChoose.value.fullName!,
                        style: TextStyleConstant.black16RobotoBold,
                      ),
                      subtitle: Text(
                        controller.staffChoose.value.level!,
                      ),
                    )),
              SizedBox(
                height: 5,
              ),
              Container(
                margin:
                    EdgeInsets.only(bottom: UtilsReponsive.height(context, 5)),
                width: double.infinity,
                height: UtilsReponsive.height(context, 40),
                child: ElevatedButton(
                    onPressed: () async {
                      // controller.testCar(true);
                      if (controller.staffChoose.value.mechanicId == 0) {
                        List<Staff> listStaff =
                            await GarageApi.getAllSatffByGarage(
                                controller.garage.garageId.toString());
                        await _showBottomEmploy(context, listStaff);
                      } else {
                        controller.removeStaff();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: TextStyle(),
                    ),
                    child: Obx(
                      () => Text(
                          controller.staffChoose.value.mechanicId == 0
                              ? "Chọn"
                              : "Làm mới",
                          style: TextStyleConstant.black16RobotoBold),
                    )),
              ),
              SizedBox(height: 5),
              Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () async {
                      await _showInfoLevel(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.info_outline, size: 12, color: Colors.grey),
                        Text(
                          'Trình độ của thợ sửa chữa ',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ))
            ]),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Chọn ngày',
                style: TextStyleConstant.black16RobotoBold,
              )),
          Container(
              height: UtilsReponsive.height(context, 250),
              margin: EdgeInsets.symmetric(
                  vertical: UtilsReponsive.height(context, 20)),
              decoration: BoxDecoration(
                  color: ColorsManager.primary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20)),
              child: Obx(
                () => CalendarDatePicker2(
                  config: CalendarDatePicker2Config(
                    currentDate: controller.dateChoose.value,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 5)),
                    calendarType: CalendarDatePicker2Type.single,
                    centerAlignModePicker: true,
                    selectedDayTextStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                    selectedDayHighlightColor: ColorsManager.primary,
                  ),
                  onValueChanged: (dates) {
                    controller.getTimeWorking(dates[0]!);
                  },
                  value: [controller.dateChoose.value],
                ),
              )),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Chọn thời gian',
                    style: TextStyleConstant.black16RobotoBold,
                  )),
              Wrap(
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    margin: EdgeInsets.only(left: 10),
                    color: ColorsManager.primary,
                  ),
                  Text("Đang chọn"),
                  Container(
                    height: 10,
                    width: 10,
                    margin: EdgeInsets.only(left: 10),
                    color: Colors.red,
                  ),
                  Text("Bận"),
                  Container(
                      height: 10,
                      width: 10,
                      margin: EdgeInsets.only(left: 10),
                      color: Colors.grey.withOpacity(0.3)),
                  Text("Trống"),
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Obx(() => controller.listTimeWorking.length == 0
                  ? SizedBox()
                  : GridView.count(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      childAspectRatio: (1 / .4),
                      crossAxisCount: 3,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 8.0,
                      children: List.generate(
                          controller.listTimeWorking.value.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            if (controller
                                .listTimeWorking[index].isAvailable!) {
                              controller.timeChoose.value =
                                  controller.listTimeWorking[index].hour!;
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: !controller
                                      .listTimeWorking[index].isAvailable!
                                  ? Colors.red
                                  : controller.timeChoose !=
                                          controller.listTimeWorking[index].hour
                                      ? Colors.grey.withOpacity(0.3)
                                      : ColorsManager.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Text(
                                controller.listTimeWorking[index].hour!,
                                style: TextStyle(
                                    color: controller.timeChoose.value ==
                                                controller
                                                    .listTimeWorking[index]
                                                    .hour! ||
                                            !controller.listTimeWorking[index]
                                                .isAvailable!
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                        );
                      }),
                    )))
        ]),
      ),
    );
  }

  Container _page4(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: UtilsReponsive.width(context, 30),
            vertical: UtilsReponsive.height(context, 30)),
        child: Obx(
          () => controller.isRefeshService.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: ColorsManager.primary,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      Text(
                        "Xác Nhận Đặt Lịch",
                        style: TextStyleConstant.black22RobotoBold,
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              // height: UtilsReponsive.height(context, 200),
                              width: UtilsReponsive.height(context, 330),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.5)),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.car_crash,
                                          color: ColorsManager.primary,
                                        ),
                                        SizedBox(
                                            width: UtilsReponsive.width(
                                                context, 10)),
                                        Obx(() => Text(
                                              controller.carChoose.value!
                                                      .carBrand ??
                                                  '- -',
                                              style: TextStyleConstant
                                                  .black16RobotoBold,
                                            ))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          UtilsReponsive.height(context, 10)),
                                  Padding(
                                      padding: EdgeInsets.only(
                                        left: UtilsReponsive.width(context, 40),
                                      ),
                                      child: Obx(
                                        () => Text(
                                          (controller.name.value) +
                                              " - ${controller.carChoose.value!.carLicensePlate!}",
                                          style:
                                              TextStyleConstant.black16Roboto,
                                        ),
                                      )),
                                  SizedBox(
                                      height:
                                          UtilsReponsive.height(context, 15)),
                                  Container(
                                    height: 2,
                                    width: double.infinity,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Obx(
                                        () => Row(
                                          children: [
                                            Icon(
                                              Icons.alarm,
                                              color: ColorsManager.primary,
                                            ),
                                            SizedBox(
                                                width: UtilsReponsive.width(
                                                    context, 10)),
                                            Text(
                                                controller.timeChoose.value
                                                        .isEmpty
                                                    ? '- -'
                                                    : controller
                                                        .timeChoose.value,
                                                style: TextStyleConstant
                                                    .black16RobotoBold),
                                            SizedBox(
                                                width: UtilsReponsive.width(
                                                    context, 10)),
                                            Text(
                                                DateFormat('MM/dd/yyyy').format(
                                                    controller
                                                        .dateChoose.value),
                                                style: TextStyleConstant
                                                    .black16RobotoBold)
                                          ],
                                        ),
                                      )),
                                  SizedBox(
                                      height:
                                          UtilsReponsive.height(context, 10)),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: ColorsManager.primary,
                                        ),
                                        SizedBox(
                                            width: UtilsReponsive.width(
                                                context, 10)),
                                        Text(controller.garage.garageName!,
                                            style: TextStyleConstant
                                                .black16RobotoBold)
                                      ],
                                    ),
                                  ),
                                  Text(
                                    controller.garage.garageAddress!,
                                    style: TextStyleConstant.black16RobotoBold,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                                height: UtilsReponsive.height(context, 30)),
                            Container(
                              height: 2,
                              width: double.infinity,
                              color: Colors.grey.withOpacity(0.3),
                            ),
                            SizedBox(
                                height: UtilsReponsive.height(context, 30)),
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Dịch vụ đã chọn'),
                                  SizedBox(
                                      height:
                                          UtilsReponsive.height(context, 10)),
                                  Obx(() {
                                    log(controller.listSerChoose.value
                                            .toString() +
                                        ": CBD");
                                    return ListView.separated(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          controller.listServices.value.length,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                              height: UtilsReponsive.height(
                                                  context, 10)),
                                      itemBuilder: (context, index) => Obx(() {
                                        bool isNotHave = true;
                                        controller.listServices.value[index]
                                            .servicListDtos!
                                            .forEach((element) {
                                          log("listServices : ${controller.listSerChoose.value.contains(element.serviceDetailId)}");

                                          if (controller.listSerChoose.value
                                              .contains(
                                                  element.serviceDetailId)) {
                                            isNotHave = false;
                                          }
                                        });
                                        return isNotHave
                                            ? SizedBox.shrink()
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    controller
                                                        .listServices[index]
                                                        .serviceGroup!,
                                                    style: TextStyleConstant
                                                        .black16RobotoBold,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  ListView.separated(
                                                      separatorBuilder:
                                                          (context, index1) =>
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: controller
                                                          .listServices[index]
                                                          .servicListDtos!
                                                          .length,
                                                      itemBuilder:
                                                          (context, index1) {
                                                        if (controller
                                                            .listSerChoose.value
                                                            .contains(controller
                                                                .listServices[
                                                                    index]
                                                                .servicListDtos![
                                                                    index1]
                                                                .serviceDetailId)) {
                                                          log("Check");
                                                          return Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                flex: 2,
                                                                child: Text(
                                                                    controller
                                                                        .listServices[
                                                                            index]
                                                                        .servicListDtos![
                                                                            index1]
                                                                        .serviceName!,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black54)),
                                                              ),
                                                              Expanded(
                                                                  child: Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                    controller
                                                                        .listServices[
                                                                            index]
                                                                        .servicListDtos![
                                                                            index1]
                                                                        .servicePrice!
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black54)),
                                                              ))
                                                            ],
                                                          );
                                                        } else {
                                                          return SizedBox();
                                                        }
                                                      }),
                                                ],
                                              );
                                      }),
                                    );
                                  }),
                                ],
                              ),
                            ),
                            SizedBox(
                                height: UtilsReponsive.height(context, 10)),
                            Container(
                                height: 2,
                                width: double.infinity,
                                color: Colors.grey.withOpacity(0.3)),
                            SizedBox(
                                height: UtilsReponsive.height(context, 10)),
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Áp dụng mã giảm giá',
                                    style: TextStyleConstant.black16RobotoBold,
                                  ),
                                  SizedBox(
                                      height:
                                          UtilsReponsive.height(context, 10)),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    // height: UtilsReponsive.height(context, 58),
                                    // width: UtilsReponsive.width(context, 328),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Colors.grey.withOpacity(0.3)),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                              controller.coupon.value
                                                      .couponCode!.isNotEmpty
                                                  ? controller
                                                      .coupon.value.couponCode!
                                                  : 'Chọn mã giảm giá',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 18)),
                                        ),
                                        Expanded(
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white),
                                                onPressed: () {
                                                  Get.toNamed(
                                                      Routes.COUPON_VIEW,
                                                      arguments: controller
                                                          .garage.garageId);
                                                },
                                                child: Text(
                                                  controller
                                                          .coupon
                                                          .value
                                                          .couponCode!
                                                          .isNotEmpty
                                                      ? "Đổi"
                                                      : 'Thêm',
                                                  style: TextStyleConstant
                                                      .primary16RobotoBold,
                                                )))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                height: UtilsReponsive.height(context, 20)),
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height:
                                          UtilsReponsive.height(context, 10)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'Tạm tính',
                                          style: TextStyleConstant
                                              .primary16RobotoBold,
                                        ),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                                '${controller.originalPrice.value}',
                                                style: TextStyleConstant
                                                    .primary16RobotoBold),
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          UtilsReponsive.height(context, 10)),
                                  controller.discountedPrice.value ==
                                          '0.000 VND'
                                      ? SizedBox()
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text('Giảm giá',
                                                  style: TextStyleConstant
                                                      .grey16RobotoBold),
                                            ),
                                            Expanded(
                                                child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  '-${controller.discountedPrice.value}',
                                                  style: TextStyle(
                                                      color: Colors.black54)),
                                            ))
                                          ],
                                        ),
                                  SizedBox(
                                      height:
                                          UtilsReponsive.height(context, 20)),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: Icon(
                                        Icons.info_outline,
                                        color: ColorsManager.primary,
                                        size: 13,
                                      )),
                                      Expanded(
                                          flex: 9,
                                          child: Text(
                                              'Giá có thể thay đổi phụ thuộc vào quá trình sửa chữa có phát sinh thêm lỗi hay vì nhiều lý do khác.',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 12)))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))
                    ]),
        ));
  }

  Container _page2(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: UtilsReponsive.width(context, 30),
          vertical: UtilsReponsive.height(context, 30)),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Để chuẩn bị tốt nhất cho Quý khách, vui lòng đặt hẹn trước 4 giờ và trong thời gian làm việc từ 8h đến 16h",
            textAlign: TextAlign.justify,
            style: TextStyleConstant.red14Roboto,
          ),
          SizedBox(
            height: UtilsReponsive.height(context, 15),
          ),
          Text(
            'Danh mục',
            style: TextStyleConstant.black22RobotoBold,
          ),
          SizedBox(
            height: UtilsReponsive.height(context, 15),
          ),
          Obx(() => controller.listServices.value.isEmpty
              ? SizedBox()
              : ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 15,
                      ),
                  itemBuilder: (context, index) =>
                      controller.listServices[index].servicListDtos!.isEmpty
                          ? SizedBox()
                          : _expansionTitleService(
                              context, controller.listServices[index]),
                  itemCount: controller.listServices.value.length)),
        ]),
      ),
    );
  }

  Column _expansionTitleService(
      BuildContext context, ServiceGarage serviceGarage) {
    log("_expansionTitleService + " + serviceGarage.toJson().toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   serviceGarage.serviceGroup.toString(),
        //   style: TextStyleConstant.black16RobotoBold,
        // ),
        SizedBox(
          height: UtilsReponsive.height(context, 10),
        ),
        Container(
          margin: EdgeInsets.only(bottom: UtilsReponsive.height(context, 15)),
          decoration: BoxDecoration(
              border: Border.all(color: ColorsManager.primary),
              borderRadius: BorderRadius.circular(10)),
          child: ExpansionTile(
              iconColor: Colors.green,
              collapsedIconColor: Colors.green,
              collapsedTextColor: Colors.black,
              textColor: Colors.black,
              title: Text(
                serviceGarage.serviceGroup.toString(),
                // serviceGarage.servicListDtos![0].serviceName.toString(),
                style: TextStyle(color: Colors.black),
              ),
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: serviceGarage.servicListDtos!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    bool isChoose = controller.listSerChoose.contains(
                        serviceGarage.servicListDtos![index].serviceDetailId);
                    return StatefulBuilder(builder: (context, setN) {
                      return GestureDetector(
                        onTap: () {
                          controller
                              .addService(serviceGarage.servicListDtos![index]);
                          setN(() {
                            isChoose = controller.listSerChoose.contains(
                                serviceGarage
                                    .servicListDtos![index].serviceDetailId);
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: UtilsReponsive.width(context, 15)),
                          color: isChoose ? ColorsManager.colorFillMulti : null,
                          width: double.infinity,
                          height: UtilsReponsive.height(context, 40),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    color:
                                        isChoose ? ColorsManager.primary : null,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: isChoose
                                            ? ColorsManager.primary
                                            : Colors.black.withOpacity(0.5))),
                                width: UtilsReponsive.height(context, 25),
                                height: UtilsReponsive.height(context, 25),
                                child: Center(
                                    child: Icon(Icons.check,
                                        color: Colors.white, size: 15)),
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  serviceGarage
                                      .servicListDtos![index].serviceName
                                      .toString(),
                                  style: TextStyleConstant.black16Roboto,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
                  },
                )
              ]),
        ),
      ],
    );
  }

  Container _page1(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: UtilsReponsive.height(context, 20),
          horizontal: UtilsReponsive.width(context, 23)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Thông tin cá nhân",
                style: TextStyleConstant.black22RobotoBold,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            RichText(
              text: new TextSpan(
                style: new TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  new TextSpan(text: 'Họ & tên'),
                  new TextSpan(text: '*', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(
              () => FormFieldWidget(
                  isEnabled: false,
                  suffixIcon: SvgPicture.asset(ImageAssets.edit_icon,
                      fit: BoxFit.scaleDown,
                      height: UtilsReponsive.height(context, 16),
                      width: UtilsReponsive.height(context, 16)),
                  padding: 10,
                  initValue: controller.name.value,
                  textInputType: TextInputType.text,
                  labelText: "Nhập tên",
                  errorText: controller.errNameInput.value,
                  setValueFunc: controller.setValueName),
            ),
            SizedBox(
              height: 16,
            ),
            RichText(
              text: new TextSpan(
                style: new TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  new TextSpan(text: 'Số điện thoại'),
                  new TextSpan(text: '*', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(
              () => FormFieldWidget(
                  isEnabled: false,
                  suffixIcon: SvgPicture.asset(ImageAssets.edit_icon,
                      fit: BoxFit.scaleDown,
                      height: UtilsReponsive.height(context, 16),
                      width: UtilsReponsive.height(context, 16)),
                  initValue: controller.phoneNumber.value,
                  padding: 10,
                  textInputType: TextInputType.number,
                  labelText: "Nhập số điện thoại",
                  errorText: controller.errPhoneInput.value,
                  setValueFunc: controller.setValuePhone),
            ),
            SizedBox(
              height: UtilsReponsive.height(context, 32),
            ),
            Container(
              height: 1,
              color: Colors.grey,
              width: double.infinity,
            ),
            SizedBox(
              height: UtilsReponsive.height(context, 25),
            ),
            Obx(
              () => controller.haveCar.value
                  ? _availbleCar(context, controller.carChoose.value!)
                  : _optionChooseCar(context),
            )
          ],
        ),
      ),
    );
  }

  Container _optionChooseCar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(UtilsReponsive.height(context, 15)),
      height: UtilsReponsive.height(context, 310),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: ColorsManager.primary)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Thông tin xe',
                style: TextStyleConstant.black16Roboto,
              ),
            ),
            Obx(() => Expanded(
                child: controller.errCarChoose.value.isNotEmpty
                    ? Text(
                        controller.errCarChoose.value,
                        style: TextStyleConstant.red14Roboto,
                      )
                    : SizedBox()))
          ],
        ),
        Obx(
          () => Row(children: [
            Radio<String>(
              activeColor: ColorsManager.primary,
              value: controller.listChoiceOptionCar[0],
              groupValue: controller.choiceOptionCar.value,
              onChanged: (String? value) {
                controller.choiceOptionCar.value = value!;
              },
            ),
            Text(controller.listChoiceOptionCar[0]),
          ]),
        ),
        Obx(
          () => controller.choiceOptionCar.value !=
                  controller.listChoiceOptionCar[0]
              ? SizedBox()
              : Container(
                  margin: EdgeInsets.only(
                      bottom: UtilsReponsive.height(context, 5)),
                  width: double.infinity,
                  height: UtilsReponsive.height(context, 32),
                  child: ElevatedButton(
                      onPressed: () {
                        // controller.testCar(true);
                        Get.toNamed(Routes.LIST_MYCAR, arguments: false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textStyle: TextStyle(),
                      ),
                      child: Text("Chọn",
                          style: TextStyleConstant.white14RobotoBold)),
                ),
        ),
        Obx(() => Row(children: [
              Radio<String>(
                activeColor: ColorsManager.primary,
                value: controller.listChoiceOptionCar[1],
                groupValue: controller.choiceOptionCar.value,
                onChanged: (String? value) {
                  controller.choiceOptionCar.value = value!;
                },
              ),
              Text(controller.listChoiceOptionCar[1]),
            ])),
        Obx(
          () => controller.choiceOptionCar.value !=
                  controller.listChoiceOptionCar[1]
              ? SizedBox()
              : Container(
                  margin: EdgeInsets.only(
                      bottom: UtilsReponsive.height(context, 5)),
                  width: double.infinity,
                  height: UtilsReponsive.height(context, 32),
                  child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.CREATE_NEW_CAR);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: ColorsManager.primary)),
                        textStyle: TextStyle(),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(ImageAssets.plus_icon),
                          Text("Thêm một phương tiện mới",
                              style: TextStyleConstant.primary14RobotoBold),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      )),
                ),
        )
      ]),
    );
  }

  Container _availbleCar(BuildContext context, Car car) {
    return Container(
      padding: EdgeInsets.all(UtilsReponsive.height(context, 15)),
      height: UtilsReponsive.height(context, 200),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: ColorsManager.primary)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.car_crash,
                      color: ColorsManager.primary,
                    ),
                    Text(
                      car.carBrand ?? '',
                      style: TextStyleConstant.primary16RobotoBold,
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      controller.removeCar();
                    },
                    icon: Icon(Icons.close))
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: UtilsReponsive.height(context, 5)),
              height: 0.5,
              width: double.infinity,
              color: Colors.grey,
            ),
            RichText(
              text: new TextSpan(
                children: <TextSpan>[
                  new TextSpan(
                      text: 'Biển số xe:  ',
                      style: TextStyleConstant.black16Roboto),
                  new TextSpan(
                      text: '${car.carLicensePlate ?? ''}',
                      style: TextStyleConstant.black16RobotoBold),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              text: new TextSpan(
                children: <TextSpan>[
                  new TextSpan(
                      text: 'Loại xe:  ',
                      style: TextStyleConstant.black16Roboto),
                  new TextSpan(
                      text:
                          '${car.numberOfCarLot ?? ''} chỗ - ${car.carFuelType ?? ''}',
                      style: TextStyleConstant.black16RobotoBold),
                ],
              ),
            )
          ]),
    );
  }

  Container _headerStep() {
    return Container(
        child: Center(
      child: Obx(
        () => Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  await controller.onTapChangePage(0);
                },
                child: CircleAvatar(
                  backgroundColor: ColorsManager.primary,
                  child: Text(
                    '1',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
              height: 3,
              width: double.infinity,
              color: controller.indexPage < 1
                  ? ColorsManager.primary.withOpacity(0.3)
                  : ColorsManager.primary,
            )),
            Expanded(
              child: InkWell(
                onTap: () async {
                  await controller.onTapChangePage(1);
                },
                child: CircleAvatar(
                  backgroundColor: controller.indexPage < 1
                      ? ColorsManager.primary.withOpacity(0.3)
                      : ColorsManager.primary,
                  child: Text(
                    '2',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
              height: 3,
              width: double.infinity,
              color: controller.indexPage < 2
                  ? ColorsManager.primary.withOpacity(0.3)
                  : ColorsManager.primary,
            )),
            Expanded(
              child: InkWell(
                onTap: () async {
                  await controller.onTapChangePage(2);
                },
                child: CircleAvatar(
                  backgroundColor: controller.indexPage < 2
                      ? ColorsManager.primary.withOpacity(0.3)
                      : ColorsManager.primary,
                  child: Text(
                    '3',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
              height: 3,
              width: double.infinity,
              color: controller.indexPage < 3
                  ? ColorsManager.primary.withOpacity(0.3)
                  : ColorsManager.primary,
            )),
            Expanded(
              child: InkWell(
                onTap: () async {
                  await controller.onTapChangePage(3);
                },
                child: CircleAvatar(
                  backgroundColor: controller.indexPage < 3
                      ? ColorsManager.primary.withOpacity(0.3)
                      : ColorsManager.primary,
                  child: Text(
                    '4',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  _showInfoLevel(BuildContext context) async {
    await Get.defaultDialog(
        titlePadding: EdgeInsets.all(0),
        title: '',
        content: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    children: [
                      Icon(Icons.info_outline, size: 16, color: Colors.grey),
                      SizedBox(width: 5),
                      Text(
                        'Bảng cấp độ kỹ năng',
                        style: TextStyleConstant.primary22RobotoBold,
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.close,
                        size: 22,
                      ))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Bậc thợ 1/3 (Sơ cấp)',
                style: TextStyleConstant.black16RobotoBold,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Đã hoàn thành khóa đào tạo Cơ bản của MeCar System.',
                style: TextStyleConstant.grey16RobotoBold,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Bậc thợ 2/3 (Trung cấp)',
                style: TextStyleConstant.black16RobotoBold,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Đã hoàn thành khóa đào tạo Nâng cao của MeCar System.',
                style: TextStyleConstant.grey16RobotoBold,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Bậc thợ 3/3 (Chuyên nghiệp)',
                style: TextStyleConstant.black16RobotoBold,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Đã hoàn thành khóa đào tạo Chuyên nghiệp của MeCar System.',
                style: TextStyleConstant.grey16RobotoBold,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: UtilsReponsive.height(context, 30),
                child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.primary),
                    child: Text(
                      'Đã hiểu',
                      style: TextStyleConstant.white16RobotoBold,
                    )),
              )
            ],
          ),
        ));
  }

  _showBottomEmploy(BuildContext context, List<Staff> listStaff) async {
    Get.bottomSheet(Container(
      padding: EdgeInsets.all(10),
      height: UtilsReponsive.height(context, 800),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Chọn thợ',
            style: TextStyleConstant.primary16RobotoBold,
          ),
          SizedBox(
            height: 10,
          ),
          // Container(
          //   width: double.infinity,
          //   height: 0.5,
          //   color: Colors.grey,
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // Expanded(
          //     child: Row(
          //   children: [
          //   Container(
          //     height: UtilsReponsive.height(context, 50),
          //     width: UtilsReponsive.height(context, 50),
          //     padding: EdgeInsets.all(10),
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       border: Border.all(color:ColorsManager.primary)
          //     ),
          //     child: SvgPicture.asset('assets/icons/suff.svg',fit:BoxFit.fill,),
          //   ),
          //   SizedBox(width: 20,),
          //     Text('Chọn bất kỳ ai',style: TextStyleConstant.black16RobotoBold,)
          //   ],
          // )),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 0.5,
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              flex: 8,
              child: ListView.separated(
                itemCount: listStaff.length,
                separatorBuilder: (context, index) => Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  height: 0.5,
                  color: Colors.grey,
                ),
                itemBuilder: (context, index) => ListTile(
                  trailing: controller.staffChoose.value.mechanicId ==
                          listStaff[index].mechanicId
                      ? Icon(
                          Icons.check,
                          color: ColorsManager.primary,
                        )
                      : null,
                  selectedTileColor: ColorsManager.primary,
                  selectedColor: ColorsManager.primary,
                  selected: controller.staffChoose.value.mechanicId ==
                      listStaff[index].mechanicId,
                  onTap: () {
                    controller.chooseStaff(listStaff[index]);
                    Get.back();
                  },
                  leading: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          height: UtilsReponsive.height(Get.context!, 80),
                          width: UtilsReponsive.height(Get.context!, 80),
                          imageUrl: listStaff[index].image!,
                          errorWidget: (context, url, error) => Image.asset(
                            ImageAssets.card,
                            fit: BoxFit.fill,
                          ),
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                      radius: 40,
                    ),
                  ),
                  title: Text(
                    listStaff[index].fullName!,
                    style: TextStyleConstant.black16RobotoBold,
                  ),
                  subtitle: Text(
                    listStaff[index].level!,
                  ),
                ),
              ))
        ],
      ),
    ));
  }
}
