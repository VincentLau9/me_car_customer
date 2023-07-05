import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_bindings.dart';

import '../controllers/map_explore_controller.dart';

class MapExploreBinding extends BaseBindings {
  @override
  void injectService() {
    Get.lazyPut<MapExploreController>(
      () => MapExploreController(),
    );
  }
}
