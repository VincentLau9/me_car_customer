import 'dart:developer';

import 'package:get/get.dart';
import 'package:me_car_customer/app/api/garage_api.dart';
import 'package:me_car_customer/app/base/base_controller.dart';
import 'package:me_car_customer/app/model/garage.dart';

class TabHomeController extends BaseController {
  //TODO: Implement TabHomeController

  final isLoading = true.obs;
  RxList<GarageModel> listGarage = <GarageModel>[].obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    await getSomeGarage();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getSomeGarage() async {
    try {
      isLoading(true);
      listGarage.value = await GarageApi.searchGarage(0, 0);
      listGarage.shuffle();
      isLoading(false);
    } catch (e) {
      log(e.toString());
      listGarage.value = [];
      isLoading(false);
    }
  }
}
