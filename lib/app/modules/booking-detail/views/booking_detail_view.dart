import 'dart:developer';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_view.dart';
import 'package:me_car_customer/app/modules/booking-detail/views/booking_detail_warranty.dart';
import 'package:me_car_customer/app/resources/assets_manager.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/resources/text_style.dart';
import 'package:me_car_customer/app/routes/app_pages.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quickalert/quickalert.dart';

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
                                Get.offAllNamed(Routes.HOME);
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
                            child: SizedBox(),
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
                    : RefreshIndicator(
                        onRefresh: () async {
                          controller.loadBookingDetail(controller.idBooking);
                        },
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Container(
                                    width: UtilsReponsive.width(context, 320),
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
                                            title: Text(controller.bookingDetail
                                                    .value.carName! +
                                                "\n${controller.bookingDetail.value.carLicensePlate}"),
                                            subtitle: Text(
                                                '${controller.bookingDetail.value.customerName}'),
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
                                                    controller.bookingDetail
                                                        .value.garageAddress!,
                                                    maxLines: 4,
                                                    style: TextStyleConstant
                                                        .black14Roboto,
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
                                                  controller.bookingDetail.value
                                                      .waitForAccept!,
                                                  context)
                                            ],
                                          ),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          controller.bookingDetail.value
                                                      .warrantyReason ==
                                                  ""
                                              ? SizedBox(
                                                  height: 2,
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Wrap(
                                                      children: [
                                                        SvgPicture.asset(
                                                            IconAssets
                                                                .status_icon),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          'Đơn bảo hành: ',
                                                          style: TextStyleConstant
                                                              .black16RobotoBold,
                                                        )
                                                      ],
                                                    ),
                                                    // Expanded(
                                                    //   child: SizedBox(
                                                    //     child: Text(
                                                    //       controller
                                                    //           .bookingDetail
                                                    //           .value
                                                    //           .warrantyReason!,
                                                    //       maxLines: 4,
                                                    //       style:
                                                    //           TextStyleConstant
                                                    //               .black14Roboto,
                                                    //     ),
                                                    //   ),
                                                    // )
                                                  ],
                                                ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          controller.bookingDetail.value
                                                      .warrantyReason ==
                                                  ""
                                              ? SizedBox(
                                                  height: 2,
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Wrap(
                                                      children: [
                                                        // Icon(
                                                        //   Icons.add_box,
                                                        //   color: Colors.green,
                                                        // ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          'Lý do bảo hành: ',
                                                          style: TextStyleConstant
                                                              .black16RobotoBold,
                                                        )
                                                      ],
                                                    ),
                                                    Expanded(
                                                      child: SizedBox(
                                                        child: Text(
                                                          controller
                                                              .bookingDetail
                                                              .value
                                                              .warrantyReason!,
                                                          maxLines: 4,
                                                          style:
                                                              TextStyleConstant
                                                                  .black14Roboto,
                                                        ),
                                                      ),
                                                    )
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
                                            constraints:
                                                BoxConstraints.tightFor(
                                                    width: context.width),
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                shape:
                                                    MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
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
                                                        embeddedImage:
                                                            AssetImage(
                                                          ImageAssets.logo,
                                                        ),
                                                        data: controller
                                                            .idBooking
                                                            .toString(),
                                                        version:
                                                            QrVersions.auto,
                                                        size: UtilsReponsive
                                                            .height(
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
                                  height: 5,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.to(BookingWarranty(
                                      bookingDetail:
                                          controller.bookingDetail.value,
                                    ));
                                  },
                                  child: Text(
                                    'Xem bảo hành các sản phẩm',
                                    // style: TextStyleConstant.black12Roboto,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: controller.bookingDetail.value
                                      .groupServiceBookingDetailDtos!.length,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                          height: UtilsReponsive.height(
                                              context, 10)),
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
                                          style: TextStyleConstant
                                              .black14RobotoBold,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        ListView.separated(
                                            separatorBuilder:
                                                (context, index1) => SizedBox(
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
                                                    child: Row(
                                                      children: [
                                                        Expanded(
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
                                                                  decoration: controller
                                                                          .bookingDetail
                                                                          .value
                                                                          .groupServiceBookingDetailDtos![
                                                                              index]
                                                                          .serviceListBookingDetailDtos![
                                                                              index1]
                                                                          .isNew!
                                                                      ? TextDecoration
                                                                          .none
                                                                      : TextDecoration
                                                                          .lineThrough,
                                                                  color: Colors
                                                                      .black54)),
                                                        ),
                                                      ],
                                                    ),
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
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                            decoration: controller
                                                                    .bookingDetail
                                                                    .value
                                                                    .groupServiceBookingDetailDtos![
                                                                        index]
                                                                    .serviceListBookingDetailDtos![
                                                                        index1]
                                                                    .isNew!
                                                                ? TextDecoration
                                                                    .none
                                                                : TextDecoration
                                                                    .lineThrough,
                                                            color: Colors
                                                                .black54)),
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
                                          style: TextStyleConstant
                                              .grey16RobotoBold),
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
                                      style:
                                          TextStyleConstant.black22RobotoBold,
                                    ),
                                    Text(
                                      controller
                                          .bookingDetail.value.finalPrice!,
                                      style:
                                          TextStyleConstant.primary22RobotoBold,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                controller.bookingDetail.value.waitForAccept!
                                    ? _bottomButtonAccept(context)
                                    : controller.bookingDetail.value
                                                .bookingStatus ==
                                            "CheckIn"
                                        ? _bottomButton(context)
                                        : controller.bookingDetail.value
                                                    .bookingStatus ==
                                                "Completed"
                                            ? _bottomButtonCompleted(context)
                                            : controller.bookingDetail.value
                                                        .bookingStatus ==
                                                    "Canceled"
                                                ? _bottomButtonCanceled(context)
                                                : _bottomButtonPendding(context)
                              ],
                            ),
                          ),
                        ),
                      ),
              )),
        ])));
  }

  Row _bottomButtonCanceled(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: context.width),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                padding: MaterialStateProperty.all(EdgeInsets.all(14)),
              ),
              child: Text(
                "Đã huỷ đơn",
                style: TextStyleConstant.white16Roboto,
              ),
              onPressed: () async {},
            ),
          ),
        ),
        // SizedBox(
        //   width: 10,
        // ),
        // Expanded(
        //   child: ConstrainedBox(
        //     constraints: BoxConstraints.tightFor(width: context.width),
        //     child: ElevatedButton(
        //       style: ButtonStyle(
        //         shape: MaterialStateProperty.all(
        //           RoundedRectangleBorder(
        //             side: BorderSide(color: Colors.red),
        //             borderRadius: BorderRadius.circular(20),
        //           ),
        //         ),
        //         backgroundColor: MaterialStateProperty.all(Colors.white),
        //         padding: MaterialStateProperty.all(EdgeInsets.all(14)),
        //       ),
        //       child: Text(
        //         "Báo cáo",
        //         style: TextStyle(color: Colors.red, fontSize: 16),
        //       ),
        //       onPressed: () async {},
        //     ),
        //   ),
        // )
      ],
    );
  }

  Row _bottomButtonAccept(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: context.width),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                backgroundColor:
                    MaterialStateProperty.all(ColorsManager.primary),
                padding: MaterialStateProperty.all(EdgeInsets.all(14)),
              ),
              child: Text(
                "Chấp nhận",
                style: TextStyleConstant.white16Roboto,
              ),
              onPressed: () async {
                controller.acceptNewBooking(true);
              },
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: context.width),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                padding: MaterialStateProperty.all(EdgeInsets.all(14)),
              ),
              child: Text(
                "Từ chối",
                style: TextStyleConstant.white16Roboto,
              ),
              onPressed: () async {
                controller.acceptNewBooking(false);
              },
            ),
          ),
        ),
        // Expanded(
        //   child: ConstrainedBox(
        //     constraints: BoxConstraints.tightFor(width: context.width),
        //     child: ElevatedButton(
        //       style: ButtonStyle(
        //         shape: MaterialStateProperty.all(
        //           RoundedRectangleBorder(
        //             side: BorderSide(color: Colors.red),
        //             borderRadius: BorderRadius.circular(20),
        //           ),
        //         ),
        //         backgroundColor: MaterialStateProperty.all(Colors.white),
        //         padding: MaterialStateProperty.all(EdgeInsets.all(14)),
        //       ),
        //       child: Text(
        //         "Báo cáo",
        //         style: TextStyle(color: Colors.red, fontSize: 16),
        //       ),
        //       onPressed: () async {},
        //     ),
        //   ),
        // )
      ],
    );
  }

  Row _bottomButtonCompleted(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: context.width),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                backgroundColor:
                    MaterialStateProperty.all(ColorsManager.primary),
                padding: MaterialStateProperty.all(EdgeInsets.all(14)),
              ),
              child: Text(
                "Đánh giá",
                style: TextStyleConstant.white16Roboto,
              ),
              onPressed: () async {
                Get.bottomSheet(Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      color: Colors.white),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Trải nghiệm của bạn về dịch vụ như thế nào?"),
                        SizedBox(
                          height: 10,
                        ),
                        RatingBar.builder(
                          initialRating: 4,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: ColorsManager.primary,
                          ),
                          onRatingUpdate: (rating) {
                            controller.setRatting(rating);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Obx(() => Text(
                              controller.listStatusString[
                                      controller.ratting.value - 1]
                                  .toString(),
                              textAlign: TextAlign.center,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Obx(() => Wrap(
                            children: controller
                                .listTemplate[controller.ratting.value]!
                                .map((e) => GestureDetector(
                                      onTap: () {
                                        controller.commentChoice.value = e;
                                      },
                                      child: Container(
                                          margin: EdgeInsets.all(2),
                                          child: Chip(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                side: BorderSide(
                                                    color:
                                                        ColorsManager.primary,
                                                    width: 1.0),
                                              ),
                                              backgroundColor: controller
                                                          .commentChoice
                                                          .value ==
                                                      e
                                                  ? ColorsManager.primary
                                                  : Colors.white,
                                              label: Text(
                                                e,
                                                style: controller.commentChoice
                                                            .value ==
                                                        e
                                                    ? TextStyleConstant
                                                        .white14Roboto
                                                    : TextStyleConstant
                                                        .black14Roboto,
                                              ))),
                                    ))
                                .toList())),
                        TextFormField(
                            controller: controller.textEditingController,
                            maxLines: 4,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: "Viết đánh giá",
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: ColorsManager.primary, width: 1),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorsManager.primary),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        ConstrainedBox(
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
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(14)),
                            ),
                            child: Text(
                              "Gửi đánh giá",
                              style: TextStyleConstant.white16Roboto,
                            ),
                            onPressed: () async {
                              await controller.createRatting();
                              // Get.toNamed(Routes.BOOKING_SERVICE_STATUS,
                              //     arguments: controller.idBooking);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
              },
            ),
          ),
        ),
        // SizedBox(
        //   width: 10,
        // ),
        // Expanded(
        //   child: ConstrainedBox(
        //     constraints: BoxConstraints.tightFor(width: context.width),
        //     child: ElevatedButton(
        //       style: ButtonStyle(
        //         shape: MaterialStateProperty.all(
        //           RoundedRectangleBorder(
        //             side: BorderSide(color: Colors.red),
        //             borderRadius: BorderRadius.circular(20),
        //           ),
        //         ),
        //         backgroundColor: MaterialStateProperty.all(Colors.white),
        //         padding: MaterialStateProperty.all(EdgeInsets.all(14)),
        //       ),
        //       child: Text(
        //         "Báo cáo",
        //         style: TextStyle(color: Colors.red, fontSize: 16),
        //       ),
        //       onPressed: () async {},
        //     ),
        //   ),
        // )
      ],
    );
  }

  Row _bottomButtonPendding(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: context.width),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                padding: MaterialStateProperty.all(EdgeInsets.all(14)),
              ),
              child: Text(
                "Huỷ đơn",
                style: TextStyleConstant.white16Roboto,
              ),
              onPressed: () async {
                await QuickAlert.show(
                    showCancelBtn: true,
                    onCancelBtnTap: () async {
                      Get.back();
                    },
                    onConfirmBtnTap: () async {
                      controller.changeStatus();
                    },
                    confirmBtnColor: ColorsManager.primary,
                    cancelBtnTextStyle: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w600),
                    context: context,
                    type: QuickAlertType.warning,
                    title: "Xác nhận",
                    text:
                        'Bạn sẽ mất tiền cọc nếu huỷ đơn hàng sau 4 tiếng đặt đơn',
                    cancelBtnText: "Trở về",
                    confirmBtnText: "Xác nhận");
              },
            ),
          ),
        ),
        // SizedBox(
        //   width: 10,
        // ),
        // Expanded(
        //   child: ConstrainedBox(
        //     constraints: BoxConstraints.tightFor(width: context.width),
        //     child: ElevatedButton(
        //       style: ButtonStyle(
        //         shape: MaterialStateProperty.all(
        //           RoundedRectangleBorder(
        //             side: BorderSide(color: Colors.red),
        //             borderRadius: BorderRadius.circular(20),
        //           ),
        //         ),
        //         backgroundColor: MaterialStateProperty.all(Colors.white),
        //         padding: MaterialStateProperty.all(EdgeInsets.all(14)),
        //       ),
        //       child: Text(
        //         "Báo cáo",
        //         style: TextStyle(color: Colors.red, fontSize: 16),
        //       ),
        //       onPressed: () async {},
        //     ),
        //   ),
        // )
      ],
    );
  }

  Row _bottomButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: context.width),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                backgroundColor:
                    MaterialStateProperty.all(ColorsManager.primary),
                padding: MaterialStateProperty.all(EdgeInsets.all(14)),
              ),
              child: Text(
                "Tiến trình",
                style: TextStyleConstant.white16Roboto,
              ),
              onPressed: () async {
                Get.toNamed(Routes.BOOKING_SERVICE_STATUS,
                    arguments: controller.idBooking);
              },
            ),
          ),
        ),
        // SizedBox(
        //   width: 10,
        // ),
        // Expanded(
        //   child: ConstrainedBox(
        //     constraints: BoxConstraints.tightFor(width: context.width),
        //     child: ElevatedButton(
        //       style: ButtonStyle(
        //         shape: MaterialStateProperty.all(
        //           RoundedRectangleBorder(
        //             side: BorderSide(color: Colors.red),
        //             borderRadius: BorderRadius.circular(20),
        //           ),
        //         ),
        //         backgroundColor: MaterialStateProperty.all(Colors.white),
        //         padding: MaterialStateProperty.all(EdgeInsets.all(14)),
        //       ),
        //       child: Text(
        //         "Báo cáo",
        //         style: TextStyle(color: Colors.red, fontSize: 16),
        //       ),
        //       onPressed: () async {},
        //     ),
        //   ),
        // )
      ],
    );
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
