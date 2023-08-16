import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_car_customer/app/api/booking_api.dart';
import 'package:me_car_customer/app/model/booking.dart';

class BookingInprogressController extends GetxController {
  //TODO: Implement BookingInprogressController

  final count = 0.obs;
    Rx<bool> isLoading = false.obs;
  RxList<Booking> listBooking = <Booking>[].obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      await loadBooking();
    } catch (e) {
      Get.back();
       Get.snackbar('Thông báo', 'Có gì đó không đúng',
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white);
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

 loadBooking() async {
    isLoading(true);
    var response = await BookingApi.loadBooking(0);
    if (response.statusCode == 200) {
      final mapData = jsonDecode(response.body).cast<Map<String, dynamic>>();
      listBooking.value = mapData.map<Booking>((json) {
        return Booking.fromJson(json);
      }).toList();
    } else {
      listBooking.value = [];
    }
    isLoading(false);
  }
}
