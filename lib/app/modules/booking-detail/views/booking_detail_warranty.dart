import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:me_car_customer/app/model/booking-detail.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/resources/text_style.dart';

class BookingWarranty extends StatelessWidget {
  const BookingWarranty({super.key, required this.bookingDetail});
  final BookingDetail bookingDetail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            'Chi Tiết Bảo Hành',
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
          child: ListView.separated(
              padding: EdgeInsets.all(15),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: bookingDetail.groupServiceBookingDetailDtos!.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: UtilsReponsive.height(context, 10)),
              itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bookingDetail.groupServiceBookingDetailDtos![index]
                            .serviceGroup!,
                        style: TextStyleConstant.black14RobotoBold,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListView.separated(
                          padding: EdgeInsets.all(10),
                          separatorBuilder: (context, index1) => SizedBox(
                                height: 5,
                              ),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: bookingDetail
                              .groupServiceBookingDetailDtos![index]
                              .serviceListBookingDetailDtos!
                              .length,
                          itemBuilder: (context, index1) {
                            return !bookingDetail
                                    .groupServiceBookingDetailDtos![index]
                                    .serviceListBookingDetailDtos![index1]
                                    .isNew!
                                ? SizedBox.shrink()
                                : Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Expanded(
                                            child: Text(
                                                bookingDetail
                                                    .groupServiceBookingDetailDtos![
                                                        index]
                                                    .serviceListBookingDetailDtos![
                                                        index1]
                                                    .serviceName!,
                                                style: TextStyle(
                                                    decoration: bookingDetail
                                                            .groupServiceBookingDetailDtos![
                                                                index]
                                                            .serviceListBookingDetailDtos![
                                                                index1]
                                                            .isNew!
                                                        ? TextDecoration.none
                                                        : TextDecoration
                                                            .lineThrough,
                                                    color: Colors.black87)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child:
                                                Text("Hạn bảo hành sản phẩm: ",
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                    )),
                                          ),
                                          Expanded(
                                            child: Text(
                                                bookingDetail
                                                    .groupServiceBookingDetailDtos![
                                                        index]
                                                    .serviceListBookingDetailDtos![
                                                        index1]
                                                    .productWarranty
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                )),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child:
                                                Text("Hạn bảo hành dịch vụ: ",
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                    )),
                                          ),
                                          Expanded(
                                            child: Text(
                                                bookingDetail
                                                    .groupServiceBookingDetailDtos![
                                                        index]
                                                    .serviceListBookingDetailDtos![
                                                        index1]
                                                    .serviceWarranty
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                          }),
                    ],
                  )),
        ),
      ])),
    );
  }
}
