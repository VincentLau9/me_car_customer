import 'dart:convert';

import 'package:get/get.dart';
import 'package:me_car_customer/app/api/booking_api.dart';
import 'package:me_car_customer/app/base/base_controller.dart';
import 'package:me_car_customer/app/model/booking.dart';

class TabBookingListController extends BaseController {
  //TODO: Implement TabBookingListController

  final count = 0.obs;
  Rx<bool> isLoading = false.obs;
  RxList<Booking> listBooking = <Booking>[].obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    await loadBooking(0);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  loadBooking(int status) async {
    isLoading(true);
    var response;
    switch (status) {
      case 0:
        response = await BookingApi.loadBooking(0);
        break;
      case 1:
        response = await BookingApi.loadBooking(2);
        break;
      case 2:
        response = await BookingApi.loadBooking(4);
        break;
      case 3:
        response = await BookingApi.loadBooking(1);
        break;
      default:
        listBooking.value = [];
    }
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

  void increment() => count.value++;
}
