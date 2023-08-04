import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_view.dart';
import 'package:me_car_customer/app/resources/assets_manager.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/resources/text_style.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/booking_detail_controller.dart';

class BookingDetailView extends BaseView<BookingDetailController> {
  const BookingDetailView({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Column(children: [
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: UtilsReponsive.height(context, 120),
                color: Colors.white,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            flex: 4,
                            child: Center(
                                child: Text(
                              'Chi Tiết Đơn Hàng',
                              style: TextStyleConstant.black22RobotoBold,
                            )),
                          ),
                          Expanded(
                            child: SvgPicture.asset(IconAssets.more_icon),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              flex: 9,
              child: Obx(
                () => controller.isLoading.value
                    ? Center(
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  width: UtilsReponsive.width(context, 320),
                                  height: UtilsReponsive.height(context, 356),
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 0.50,
                                          color: Color(0xFFEEEEEE)),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x0F000000),
                                        blurRadius: 16,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: SvgPicture.asset(
                                              IconAssets.tick_icon),
                                          title: Text(controller
                                              .bookingDetail.value.carName!),
                                          subtitle: Text(
                                              '${controller.bookingDetail.value.customerName} \n${controller.bookingDetail.value.customerPhone}'),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                IconAssets.time_icon),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              controller.bookingDetail.value
                                                  .duration!,
                                              style: TextStyleConstant
                                                  .black16RobotoBold,
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                IconAssets.calendar_icon),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              controller.bookingDetail.value
                                                  .bookingDay!,
                                              style: TextStyleConstant
                                                  .black16RobotoBold,
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                IconAssets.location_icon),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                child: Text(
                                                  controller.bookingDetail.value
                                                      .garageAddress!,
                                                  maxLines: 4,
                                                  style: TextStyleConstant
                                                      .black12Roboto,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Wrap(
                                              children: [
                                                SvgPicture.asset(
                                                    IconAssets.status_icon),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  'Trạng thái',
                                                  style: TextStyleConstant
                                                      .black16RobotoBold,
                                                )
                                              ],
                                            ),
                                            controller.statusBooking(
                                                controller.bookingDetail.value
                                                    .bookingStatus!,
                                                context)
                                          ],
                                        ),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        DottedLine(),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        ConstrainedBox(
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
                                                  MaterialStateProperty.all(
                                                      ColorsManager.primary),
                                              padding:
                                                  MaterialStateProperty.all(
                                                      EdgeInsets.all(14)),
                                            ),
                                            child: Text(
                                              "Nhấp để lấy mã QR",
                                              style: TextStyleConstant
                                                  .white16Roboto,
                                            ),
                                            onPressed: () async {
                                              Get.dialog(Center(
                                                child: Container(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  padding: EdgeInsets.all(10),
                                                  child: Container(
                                                    color: Colors.white,
                                                    child: QrImageView(
                                                      embeddedImage: AssetImage(
                                                        ImageAssets.logo,
                                                      ),
                                                      data: controller.idBooking
                                                          .toString(),
                                                      version: QrVersions.auto,
                                                      size:
                                                          UtilsReponsive.height(
                                                              context, 260),
                                                      gapless: false,
                                                    ),
                                                  ),
                                                ),
                                              ));
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Center(
                                child: Text(
                                  'Dịch Vụ Đã Đặt',
                                  style: TextStyleConstant.black22RobotoBold,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.bookingDetail.value
                                    .groupServiceBookingDetailDtos!.length,
                                separatorBuilder: (context, index) => SizedBox(
                                    height: UtilsReponsive.height(context, 10)),
                                itemBuilder: (context, index) => Obx(() {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller
                                            .bookingDetail
                                            .value
                                            .groupServiceBookingDetailDtos![
                                                index]
                                            .serviceGroup!,
                                        style:
                                            TextStyleConstant.black14RobotoBold,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      ListView.separated(
                                          separatorBuilder: (context, index1) =>
                                              SizedBox(
                                                height: 5,
                                              ),
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: controller
                                              .bookingDetail
                                              .value
                                              .groupServiceBookingDetailDtos![
                                                  index]
                                              .serviceListBookingDetailDtos!
                                              .length,
                                          itemBuilder: (context, index1) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                      controller
                                                          .bookingDetail
                                                          .value
                                                          .groupServiceBookingDetailDtos![
                                                              index]
                                                          .serviceListBookingDetailDtos![
                                                              index1]
                                                          .serviceName!,
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black54)),
                                                ),
                                                Expanded(
                                                    child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                      controller
                                                          .bookingDetail
                                                          .value
                                                          .groupServiceBookingDetailDtos![
                                                              index]
                                                          .serviceListBookingDetailDtos![
                                                              index1]
                                                          .servicePrice!
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black54)),
                                                ))
                                              ],
                                            );
                                          }),
                                    ],
                                  );
                                }),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text('Tạm tính',
                                        style:
                                            TextStyleConstant.grey16RobotoBold),
                                  ),
                                  Expanded(
                                      child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                        '${controller.bookingDetail.value.totalPrice}',
                                        style:
                                            TextStyle(color: Colors.black54)),
                                  ))
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              controller.bookingDetail.value.discountPrice ==
                                      '0.0000 VND'
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
                                              '-${controller.bookingDetail.value.discountPrice}',
                                              style: TextStyle(
                                                  color: Colors.black54)),
                                        ))
                                      ],
                                    ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Tổng số tiền',
                                    style: TextStyleConstant.black22RobotoBold,
                                  ),
                                  Text(
                                    controller.bookingDetail.value.finalPrice!,
                                    style:
                                        TextStyleConstant.primary22RobotoBold,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ConstrainedBox(
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
                                              MaterialStateProperty.all(
                                                  ColorsManager.primary),
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.all(14)),
                                        ),
                                        child: Text(
                                          "Tiến trình",
                                          style:
                                              TextStyleConstant.white16Roboto,
                                        ),
                                        onPressed: () async {},
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints.tightFor(
                                          width: context.width),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              side:
                                                  BorderSide(color: Colors.red),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.all(14)),
                                        ),
                                        child: Text(
                                          "Báo cáo",
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 16),
                                        ),
                                        onPressed: () async {},
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
              )),
        ])));
  }

  Wrap buildService(String title, int lenght) {
    return Wrap(
      children: [
        Text(
          '$title',
          style: TextStyleConstant.black16RobotoBold,
        ),
        ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dịch vụ 1',
                      style: TextStyleConstant.black16Roboto,
                    ),
                    Text(
                      '300,000',
                      style: TextStyleConstant.black16Roboto,
                    ),
                  ],
                ),
            separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
            itemCount: lenght)
      ],
    );
  }
}
