import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_bindings.dart';

import '../controllers/update_firsttime_controller.dart';

class UpdateFirsttimeBinding extends BaseBindings {
  @override
  void injectService() {
    Get.lazyPut<UpdateFirstTimeController>(
      () => UpdateFirstTimeController(),
    );
  }
}
