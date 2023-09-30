import 'dart:convert';
import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:me_car_customer/app/api/booking_api.dart';
import 'package:me_car_customer/app/api/car_api.dart';
import 'package:me_car_customer/app/api/garage_api.dart';
import 'package:me_car_customer/app/base/base_controller.dart';
import 'package:me_car_customer/app/model/car.dart';
import 'package:me_car_customer/app/model/coupon.dart';
import 'package:me_car_customer/app/model/form-booking.dart';
import 'package:me_car_customer/app/model/garage.dart';
import 'package:me_car_customer/app/model/service_garage.dart';
import 'package:me_car_customer/app/model/staff.dart';
import 'package:me_car_customer/app/model/time_working.dart';
import 'package:me_car_customer/app/modules/booking-step/views/booking_success.dart';
import 'package:me_car_customer/app/modules/pre-booking/controllers/pre_booking_controller.dart';
import 'package:me_car_customer/app/modules/start_app/controllers/start_app_controller.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/resources/text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingStepController extends BaseController {
  //TODO: Implement BookingStepController
  BookingStepController({required this.garage});
  GarageModel garage;
  RxInt indexPage = 0.obs;
  PageController pageController = PageController();
  RxString phoneNumber = ''.obs;
  RxString name = ''.obs;
  RxString errPhoneInput = ''.obs;
  RxString errNameInput = ''.obs;
  RxString errCarChoose = '( Vui lòng chọn xe )'.obs;
  List<String> listChoiceOptionCar = [
    'Lấy từ thông tin xe của bạn',
    'Chọn xe mới'
  ];
  RxString choiceOptionCar = ''.obs;
  Rx<bool> haveCar = false.obs;
  RxList<Car> listCar = <Car>[].obs;
  Rx<Car?> carChoose = Car().obs;
  RxList<TimeWorking> listTimeWorking = <TimeWorking>[].obs;
  Rx<String> timeChoose = ''.obs;
  Rx<DateTime> dateChoose = DateTime.now().obs;
  Rx<int> durationEstimated = 0.obs;
  DateFormat dateFormat = DateFormat('MM/dd/yyyy');
  RxList<ServiceGarage> listServices = <ServiceGarage>[].obs;
  RxBool isRefeshService = false.obs;
  RxBool isEnableButton = false.obs;
  RxList<int> listSerChoose = <int>[].obs;
  Rx<Staff> staffChoose = Staff(mechanicId: 0).obs;

  Rx<String> originalPrice = '0 VNĐ'.obs;
  Rx<String> discountedPrice = '0 VNĐ'.obs;
  Rx<String> totalPrice = '0 VNĐ'.obs;
  Rx<Coupon> coupon = Coupon(couponCode: "", couponId: 0).obs;
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  @override
  Future<void> onInit() async {
    log('BookingStepController id ${garage.garageId}');
    choiceOptionCar.value = listChoiceOptionCar[0];
    name(Get.find<StartAppController>().name.value);
    phoneNumber(Get.find<StartAppController>().numberPhone.value);
    if (Get.isRegistered<PreBookingController>()) {
      dateChoose.value =
          dateFormat.parse(Get.find<PreBookingController>().txtDate.text);
    }
    getTimeWorking(dateChoose.value);

    // await getServiceOfGarage();
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await initDynamicLinks();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getServiceOfGarage(int idGarage, int numberOfCarLot) async {
    listServices.value =
        await GarageApi.getServiceOfGarage(garage.garageId!, numberOfCarLot);
  }

  void jumpToPage() {
    log("jumpToPage $indexPage");
    checkValidation();
    if (isEnableButton.value) {
      if (indexPage.value + 1 < 4) {
        indexPage++;
        pageController.animateToPage(indexPage.value,
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    }
  }

  changePage(int value) async {
    log("changePage $value");
    if (indexPage == 1) {
      await refeshService();
    } else if (indexPage == 3) {
      await checkout();
    }

    if (errNameInput.isEmpty && errPhoneInput.isEmpty) {
      indexPage.value = value;
    }
  }

  checkout() async {
    isRefeshService(true);
    var response =
        await BookingApi.checkout(listSerChoose, coupon.value.couponId ?? 0);
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      originalPrice(data["originalPrice"]);
      discountedPrice(data["discountedPrice"]);
      totalPrice(data["totalPrice"]);
    } else {}
    isRefeshService(false);
  }

  onTapChangePage(int value) async {
    checkValidation();
    if (isEnableButton.value) {
      // if (errNameInput.isEmpty && errPhoneInput.isEmpty) {
      if (value == 1) {
        await refeshService();
      } else if (value == 3) {
        await checkout();
      }
      pageController.animateToPage(value,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      // }
    }
  }

  void setValueName(String value) {
    name(value);
    checkValidation();
  }

  void setValuePhone(String value) {
    phoneNumber(value);
    checkValidation();
  }

  Future<void> initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      String result = dynamicLinkData.link.path;
      if (result.isNotEmpty) {
        if (result == "/payment-success") {
          Get.offAll(BookingSuccess());
        } else {
          Get.snackbar(
              "Thông báo", "Thanh toán không thành công. Vui lòng thử lại sao",
              backgroundColor: Colors.red.withOpacity(0.7),
              colorText: Colors.white);
        }
      } else {}
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  checkValidation() {
    // log((carChoose.value==null).toString());
    // if (name.trim().isEmpty) {
    //   errNameInput('Tên không được bỏ trống');
    // } else {
    //   errNameInput('');
    // }
    // if (phoneNumber.trim().isEmpty) {
    //   errPhoneInput('Số điện thoại bắt buộc');
    //   // } else if (phoneNumber.trim().length < 10) {
    //   //   errPhoneInput('Số điện thoại không hợp lệ');
    // } else {
    //   errPhoneInput('');
    // }
    if (!haveCar.value) {
      errCarChoose('( Vui lòng chọn xe )');
    } else {
      errCarChoose('');
    }

    if (errNameInput.isEmpty &&
        errPhoneInput.isEmpty &&
        errCarChoose.isEmpty &&
        haveCar.value) {
      log('Success');
      isEnableButton(true);
    } else {
      log('Fail');
      isEnableButton(false);
    }
  }

  loadAllCar() async {
    listCar.value = await CarApi.loadAllCar();
  }

  getNewCarLastest() async {
    await loadAllCar();
    carChoose.value = listCar.last;
    haveCar(true);
    checkValidation();
  }

  getTimeWorking(DateTime date) async {
    int duration = durationEstimated.value;
    dateChoose(date);
    listTimeWorking.value = await GarageApi.checkTimeWorking(
        dateFormat.format(date), duration, garage.garageId!);
    timeChoose('');
  }

  removeCar() {
    log('message');
    haveCar(false);
    listCar.clear();
    carChoose.value = Car();
    errCarChoose('( Vui lòng chọn xe )');
    checkValidation();
  }

  refeshService() async {
    try {
      isRefeshService(true);
      await getServiceOfGarage(
          garage.garageId!, carChoose.value!.numberOfCarLot!);
      isRefeshService(false);
    } catch (e) {
      listServices.value = [];
    }
  }

  addService(ServicListDto service) {
    if (listSerChoose.contains(service.serviceDetailId)) {
      int dura = durationEstimated.value;
      dura -= service.serviceDuration!;
      durationEstimated(dura);
      listSerChoose.remove(service.serviceDetailId);
    } else if (listSerChoose.length >= 3) {
      Get.snackbar("Thông báo", "Chỉ đặt được tối đa là 3 dịch vụ",
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white);
    } else {
      int dura = durationEstimated.value;
      dura += service.serviceDuration!;
      durationEstimated(dura);
      listSerChoose.add(service.serviceDetailId!);
    }
    log(durationEstimated.toString());
    log(listSerChoose.length.toString());
  }

  chooseStaff(Staff staff) {
    if (staffChoose.value.mechanicId == staff.mechanicId) {
      staffChoose.value.mechanicId = 0;
    } else {
      staffChoose(staff);
    }
  }

  removeStaff() {
    log("message");
    staffChoose.value.mechanicId = 0;
    staffChoose.update((staff) {
      staff = Staff(mechanicId: 0);
    });
  }

  createBooking() async {
    if (timeChoose.isEmpty) {
      Get.snackbar("Thông báo", "Bạn chưa chọn thời gian",
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white);
    } else {
      FormBooking form = FormBooking(
          couponId: coupon.value.couponId,
          customerName: name.value,
          customerPhone: phoneNumber.value,
          customerEmail: "",
          dateSelected: dateFormat.format(dateChoose.value),
          timeSelected: timeChoose.value,
          serviceList: listSerChoose,
          carId: carChoose.value!.carId ?? 0,
          mechanicId: staffChoose.value.mechanicId,
          garageId: garage.garageId!);
      log(form.toJson().toString());
      var response = await BookingApi.createBooking(form);
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        String url = jsonDecode(response.body)["paymentUrl"];
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        }
        // Get.offAll(BookingSuccess());
      } else if (response.statusCode == 404) {
        Get.snackbar("Thông báo", jsonDecode(response.body)["title"].toString(),
            backgroundColor: Colors.red.withOpacity(0.7),
            colorText: Colors.white);
      } else {
        Get.snackbar("Thông báo", "Có gì đó không đúng",
            backgroundColor: Colors.red.withOpacity(0.7),
            colorText: Colors.white);
      }
    }
  }

  chooseCoupon(Coupon couponChoose) async {
    coupon.value = couponChoose;
    await checkout();
  }
}
