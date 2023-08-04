import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_bindings.dart';

import '../controllers/list_mycar_controller.dart';

class ListMycarBinding extends BaseBindings {
  @override
  void injectService() {
    bool isFromHome = Get.arguments as bool;
    Get.lazyPut<ListMycarController>(
      () => ListMycarController(isFromHome:isFromHome),
    );
  }
}
