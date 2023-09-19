import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_car_customer/app/api/car_api.dart';
import 'package:me_car_customer/app/base/base_controller.dart';
import 'package:me_car_customer/app/model/car.dart';
import 'package:me_car_customer/app/modules/booking-step/controllers/booking_step_controller.dart';
import 'package:me_car_customer/app/modules/list-mycar/controllers/list_mycar_controller.dart';
import 'package:me_car_customer/app/modules/update-first-time/controllers/update_firsttime_controller.dart';

class CreateNewCarController extends BaseController {
  //TODO: Implement CreateNewCarController

  RxString numCar = ''.obs;
  RxString brand = ''.obs;
  RxInt numSit = 0.obs;
  RxString vinCar = "".obs;
  RxString description = "".obs;
  RxString fuelChoice = "".obs;
  List<String> listBrand = ['Honda', 'KIA', 'BMW', 'Suzuki'];
  List<String> fuelOptions = ['Xăng', 'Dầu', 'Điện'];
  List<int> listNumber = [4, 5, 7, 9];
  TextEditingController textEdittingBrand =
      TextEditingController(text: 'Chọn thương hiệu xe');
  TextEditingController textEdittingNumsit =
      TextEditingController(text: 'Chọn mẫu xe');
  TextEditingController textEdittingFuel =
      TextEditingController(text: 'Loại nhiên liệu');
  Rx<bool> lockButton = false.obs;
  Rx<bool> enableButton = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  setNumCarValue(String value) {
    numCar(value);
    checkEnableButton();
  }

  setBrandValue(String value) {
    brand(value);
    print(brand);
    textEdittingBrand.text = value;
    checkEnableButton();
  }

  setNumSitValue(int value) {
    numSit(value);
    textEdittingNumsit.text = '${value} chỗ';
  }

  setFuelChoiceValue(String value) {
    fuelChoice(value);
    textEdittingFuel.text = value;
    checkEnableButton();
  }

  setDescriptionValue(String value) {
    description(value);
    checkEnableButton();
  }

  checkEnableButton() {
    if (listBrand.contains(textEdittingBrand.text) &&
        listNumber.contains(numSit.value) &&
        fuelOptions.contains(textEdittingFuel.text) &&
        numCar.value.trim().isNotEmpty) {
      enableButton(true);
    } else {
      enableButton(false);
    }
    log(enableButton.toString());
  }

  createNewCar(bool isFistTime) async {
       Car carModel = Car();
    carModel.carBrand = textEdittingBrand.text;
    carModel.numberOfCarLot = numSit.value;
    carModel.carDescription = description.value;
    carModel.carFuelType = textEdittingFuel.text;
    carModel.carLicensePlate = numCar.value;
    log(carModel.toJson().toString());
   if(enableButton.value){
     lockButton(true);
 
    bool check = await CarApi.createCar(carModel);
    if (check) {
      if (isFistTime && Get.isRegistered<UpdateFirstTimeController>()) {
        await Get.find<UpdateFirstTimeController>().loadAllCar();
        Get.back();
      } else if (Get.isRegistered<BookingStepController>()) {
        await Get.find<BookingStepController>().getNewCarLastest();
        Get.back();
      } else {
        await Get.find<ListMycarController>().loadAllCar();
        Get.back();
      }
      Get.snackbar("Thông báo", "Tạo xe thành công",backgroundColor: Colors.green.withOpacity(0.7),
          colorText: Colors.white);
    } else {
      Get.snackbar('Thông báo', 'Có gì đó không đúng');
    }
    lockButton(false);
   }
  }
}
