import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_bindings.dart';
import 'package:me_car_customer/app/model/garageDetail.dart';

import '../controllers/garage_detail_controller.dart';

class GarageDetailBinding extends BaseBindings {
  @override
  void injectService() {
    GarageDetail garage = Get.arguments as GarageDetail;
    Get.lazyPut<GarageDetailController>(
      () => GarageDetailController(garage: garage),
    );
  }
}
