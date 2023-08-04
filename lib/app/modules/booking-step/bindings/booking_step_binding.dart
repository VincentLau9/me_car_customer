import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_bindings.dart';
import 'package:me_car_customer/app/model/garage.dart';

import '../controllers/booking_step_controller.dart';

class BookingStepBinding extends BaseBindings {
  @override
  void injectService() {
   GarageModel currentGarage = Get.arguments as GarageModel;
    Get.lazyPut<BookingStepController>(
      () => BookingStepController(garage: currentGarage),
    );
  }
}
