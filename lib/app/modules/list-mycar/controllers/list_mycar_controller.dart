import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_car_customer/app/api/car_api.dart';
import 'package:me_car_customer/app/base/base_controller.dart';
import 'package:me_car_customer/app/model/car.dart';
import 'package:me_car_customer/app/modules/booking-step/controllers/booking_step_controller.dart';

class ListMycarController extends BaseController {
  //TODO: Implement ListMycarController
  ListMycarController({required this.isFromHome});
  bool isFromHome;
  final count = 0.obs;
  RxBool isLoading = true.obs;
  RxList<Car> listCar = <Car>[].obs;
  @override
  void onInit() async {
    super.onInit();
    await loadAllCar();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
  loadAllCar() async {
    listCar.value = await CarApi.loadAllCar();
    log('ListMycarController');
    isLoading(false);
  }

  chooseCar(int index) async {
    if (!isFromHome) {
      if (listCar[index].carStatus == "NotAvailable") {
        Get.snackbar("Thông báo", "Xe đang trong quá trình lên đơn",
            backgroundColor: Colors.red.withOpacity(0.7),
            colorText: Colors.white);
      } else {
        Get.find<BookingStepController>().carChoose.value = listCar[index];
        Get.find<BookingStepController>().update();
        Get.find<BookingStepController>().haveCar(true);
        Get.find<BookingStepController>().errCarChoose('');
        Get.find<BookingStepController>().checkValidation();
        Get.back();
      }
    }
  }
}
