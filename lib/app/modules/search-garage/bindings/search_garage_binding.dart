import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_bindings.dart';

import '../controllers/search_garage_controller.dart';

class SearchGarageBinding extends BaseBindings {
  @override
  void injectService() {
   bool isSearchFromHome = Get.arguments as bool;
    Get.lazyPut<SearchGarageController>(
      () => SearchGarageController(isSearchFromHome:isSearchFromHome),
    );
  }
}
