import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:me_car_customer/app/api/garage_api.dart';
import 'package:me_car_customer/app/base/base_controller.dart';
import 'package:me_car_customer/app/model/garageDetail.dart';

class GarageDetailController extends BaseController {
  //TODO: Implement GarageDetailController

  GarageDetailController({required this.garage});
  final isLoading = true.obs;
  GarageDetail garage;
  Rx<GarageDetail> data = GarageDetail().obs;
  Rx<double> lat = 0.0.obs;
  Rx<double> lng = 0.0.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    await loadingData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  loadingData() async {
    try {
      isLoading(true);
      data.value = await GarageApi.getGarageDetail(garage.garageId!);
      data.value.km = garage.km;
      isLoading(false);
    } catch (e) {
      log(e.toString());
    }

    // km= (Geolocator.distanceBetween(data.garageLatitude!,data.garageLongitude!,10.841823064481721, 106.80984008465619)/1000).toPrecision(1);
  }
}
