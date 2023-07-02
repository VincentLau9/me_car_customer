import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_bindings.dart';
import 'package:me_car_customer/app/modules/home/controllers/tab-home-controller/tab_home_controller.dart';
import 'package:me_car_customer/app/modules/home/controllers/tab-profile-controller/tab_profile_controller.dart';
import 'package:me_car_customer/app/modules/home/controllers/tab-service-controller/tab_service_controller.dart';
import 'package:me_car_customer/app/modules/home/controllers/tab-booking-controller/tab_booking_list_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends BaseBindings {
  @override
  void injectService() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
     Get.lazyPut<TabHomeController>(
      () => TabHomeController(),
    );
    Get.lazyPut<TabServiceController>(
      () => TabServiceController(),
    );
     Get.lazyPut<TabProfileController>(
      () => TabProfileController(),
    );
    Get.lazyPut<TabBookingListController>(
      () => TabBookingListController(),
    );
  }
}
