import 'dart:convert';
import 'dart:developer';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:me_car_customer/app/api/car_api.dart';
import 'package:me_car_customer/app/api/garage_api.dart';
import 'package:me_car_customer/app/base/base_controller.dart';
import 'package:me_car_customer/app/model/car.dart';
import 'package:me_car_customer/app/model/data_search_model.dart';
import 'package:me_car_customer/app/model/garage.dart';
import 'package:me_car_customer/app/model/search_filter.dart';
import 'package:me_car_customer/app/model/service_filter.dart';
import 'package:me_car_customer/app/modules/pre-booking/views/view_result_search.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/routes/app_pages.dart';

class PreBookingController extends BaseController {
  //TODO: Implement PreBookingController

  final count = 0.obs;
  TextEditingController txtLocation = TextEditingController(text: '');
  TextEditingController txtDate = TextEditingController(text: '');
  RxString textSearch = ''.obs;
  Rx<DataSearchModel> modelSearch = DataSearchModel().obs;
  RxList<ServiceFilter> listSerFilter = <ServiceFilter>[].obs;
  DateFormat dateFormat = DateFormat('MM/dd/yyyy');
  List<int> listNumber = [4, 5, 7, 9];
  RxInt numberChoose = 0.obs;
  // RxInt idServiceChoose = 0.obs;
  RxList<ServiceFilter> serChoose = <ServiceFilter>[].obs;
  RxList<GarageModel> listGarage = <GarageModel>[].obs;
  Rx<bool> isLockButton = true.obs;
  Rx<bool> isLoading = true.obs;
  RxList<Car> listCar = <Car>[].obs;

  @override
  Future<void> onInit() async {
    DateTime now = DateTime.now();
    String formattedDate = dateFormat.format(now);
    txtDate.text = formattedDate;
    await getServiceFilter();
    // await loadAllCar();
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

  loadAllCar() async {
    listCar.value = await CarApi.loadAllCar();
    log('BookingStep');
  }

  searchGarageByFiler() async {
    if (!isLockButton.value) {
      List<int> serviceListId = [];
      serChoose.forEach((element) { serviceListId.add(element.serviceId!);});
      SearchFilter filter = SearchFilter(
          serviceList: serviceListId,
          dateSelected: txtDate.text,
          latitude: modelSearch.value.lat,
          longitude: modelSearch.value.lng,
          radiusInKm: 1000000);
      log(jsonEncode(filter.toJson()));
      listGarage.value = await GarageApi.searchGarageByFilter(filter);
      isLoading(false);
      Get.to(ViewResultSearch());
    }
  }

  chooseService(ServiceFilter service) {
    // idServiceChoose(service.serviceId);
    if (serChoose.contains(service)) {
      serChoose.remove(service);
    } else {
      serChoose.add(service);
    }
    checkEnableButton();
    // Get.back();
  }

  getServiceFilter() async {
    try {
      listSerFilter.value = await GarageApi.getServicesFilter();
    } catch (e) {
      log('getServiceFilter: $e');
    }
  }

  getResultSearching(DataSearchModel data) {
    modelSearch(data);
    txtLocation.text = modelSearch.value.description ?? "";
    textSearch.value = modelSearch.value.description ?? "";
    checkEnableButton();
    log(data.lat.toString());
  }

  showChooseDate() {
    Get.dialog(
        barrierDismissible: true,
        Scaffold(
          backgroundColor: Colors.black.withOpacity(0.4),
          body: SafeArea(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: UtilsReponsive.height(Get.context!, 300),
                width: UtilsReponsive.width(Get.context!, 300),
                child: CalendarDatePicker2(
                  config: CalendarDatePicker2Config(
                    currentDate: txtDate.text.isEmpty
                        ? DateTime.now()
                        : dateFormat.parse(txtDate.text),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 5)),
                    calendarType: CalendarDatePicker2Type.single,
                    centerAlignModePicker: true,
                    selectedDayTextStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                    selectedDayHighlightColor: ColorsManager.primary,
                  ),
                  onValueChanged: (dates) {
                    log(dates.toList().toString());
                    txtDate.text = dateFormat.format(dates[0]!).split(' ')[0];
                    checkEnableButton();
                    Get.back();
                  },
                  value: [],
                ),
              ),
            ),
          ),
        ));
  }

  checkEnableButton() {
    if (txtLocation.text.trim().isEmpty ||
        txtDate.text.trim().isEmpty ||
        // numberChoose == 0 ||
        serChoose.isEmpty) {
      isLockButton(true);
    } else {
      isLockButton(false);
    }
  }

  chooseGarage(GarageModel garage) {
    Get.toNamed(Routes.BOOKING_STEP, arguments: garage);
  }
}
