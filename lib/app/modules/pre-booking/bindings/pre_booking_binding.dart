import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_bindings.dart';

import '../controllers/pre_booking_controller.dart';

class PreBookingBinding extends BaseBindings {
  @override
  void injectService() {
    Get.lazyPut<PreBookingController>(
      () => PreBookingController(),
    );
  }
}
