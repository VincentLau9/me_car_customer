import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_bindings.dart';

import '../controllers/booking_service_status_controller.dart';

class BookingServiceStatusBinding extends BaseBindings {
  @override
  void injectService() {
    final idBooking = Get.arguments as int;
    Get.lazyPut<BookingServiceStatusController>(
      () => BookingServiceStatusController(idBooking: idBooking),
    );
  }
}
