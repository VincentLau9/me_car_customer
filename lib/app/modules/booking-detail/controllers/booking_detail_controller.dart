import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_car_customer/app/api/booking_api.dart';
import 'package:me_car_customer/app/base/base_controller.dart';
import 'package:me_car_customer/app/model/booking-detail.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';

class BookingDetailController extends BaseController {
  //TODO: Implement BookingDetailController
  BookingDetailController({required this.idBooking});
  int idBooking;
  Rx<BookingDetail> bookingDetail = BookingDetail().obs;
  Rx<bool> isLoading = true.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      log(idBooking.toString());
      isLoading(true);
      await loadBookingDetail(idBooking);
      isLoading(false);
    } catch (e) {
      Get.back();
      Get.snackbar("Thông báo", 'Có gì đó không đúng');
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  loadBookingDetail(int id) async {
    var response = await BookingApi.loadBookingDetail(id);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      bookingDetail.value = BookingDetail.fromJson(data);
    } else {
      throw Error();
    }
  }

  Widget statusBooking(String status, BuildContext context) {
    Color color = Colors.amber;
    String text = "";
    switch (status) {
      case "Pending":
        color = Colors.amber;
        text = "Sắp tới";
        break;
      case "Canceled":
        color = ColorsManager.colorCancel;
        text = "Đã huỷ";
        break;
      case "CheckIn":
        color = ColorsManager.colorCheckIn;
        text = "Đang xử lý";
        break;
      case "Completed":
        color = ColorsManager.colorDone;
        text = "Hoàn thành";
        break;
      default:
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15)),
      child: Center(
          child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      )),
    );
  }
}
