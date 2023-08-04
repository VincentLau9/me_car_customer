import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_bindings.dart';

import '../controllers/booking_detail_controller.dart';

class BookingDetailBinding extends BaseBindings {
  @override
  void injectService() {
    int id = Get.arguments as int;
    Get.lazyPut<BookingDetailController>(
      () => BookingDetailController(idBooking: id),
    );
  }
}
