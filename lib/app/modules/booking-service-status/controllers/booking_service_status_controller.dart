import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:me_car_customer/app/api/booking_api.dart';
import 'package:me_car_customer/app/base/base_controller.dart';
import 'package:me_car_customer/app/model/booking-service-status.dart';
import 'package:me_car_customer/app/model/mechanic.dart';
import 'package:me_car_customer/app/resources/assets_manager.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';

class BookingServiceStatusController extends BaseController {
  //TODO: Implement BookingServiceStatusController
  BookingServiceStatusController({required this.idBooking});
  final idBooking;
  final count = 0.obs;
  final isLoading = false.obs;
  final listData = <BookingServiceStatus>[].obs;
  final listMechaic = <Mechanic>[].obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      isLoading.value = true;
    await getBookingServiceStatus(idBooking);
    await loadMechanic(idBooking);
      isLoading.value = false;

    } catch (e) {
      
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
  loadMechanic(int idBooking)async{
  final response=  await BookingApi.getMechanic(idBooking);
    if (response.statusCode == 200) {
      final mapData = jsonDecode(response.body).cast<Map<String, dynamic>>();
      listMechaic.value = mapData.map<Mechanic>((json) {
        return Mechanic.fromJson(json);
      }).toList();
      for (var i = 0; i < listMechaic.length; i++) {
        if (listMechaic[i].isMainMechanic!) {
          final mechanic = listMechaic.removeAt(i);
          listMechaic.insert(0, mechanic);
          break;
        }
      }
   
    } else {}
  }
  getBookingServiceStatus(int idBooking) async {
    final response = await BookingApi.getBooingServiceStatus(idBooking);
    if (response.statusCode == 200) {
      final mapData = jsonDecode(response.body).cast<Map<String, dynamic>>();
      listData.value = mapData.map<BookingServiceStatus>((json) {
        return BookingServiceStatus.fromJson(json);
      }).toList();
      
    } else {}
  }

  String getPathStatus(String status) {
    switch (status) {
      case "NotStart":
        return IconAssets.notyet_icon;
      case "Done":
        return IconAssets.done_icon;
      case "Error":
        return IconAssets.fail_icon;
      case "Đang chờ":
        return IconAssets.notyet_icon;
      case "Chưa Hoàn Thành":
        return IconAssets.fail_icon;
      case "Đã Hoàn Thành":
        return IconAssets.done_icon;
      default:
        return IconAssets.notyet_icon;
    }
  }
  Color getColorStatus(String status) {
    switch (status) {
      case "NotStart":
        return Colors.grey;
      case "Done":
        return ColorsManager.primary;
      case "Error":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
