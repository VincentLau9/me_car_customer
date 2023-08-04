import 'package:get/get.dart';

import '../controllers/booking_inprogress_controller.dart';

class BookingInprogressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingInprogressController>(
      () => BookingInprogressController(),
    );
  }
}
