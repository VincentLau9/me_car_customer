import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_bindings.dart';

import '../controllers/create_new_car_controller.dart';

class CreateNewCarBinding extends BaseBindings {
  @override
  void injectService() {
    Get.lazyPut<CreateNewCarController>(
      () => CreateNewCarController(),
    );
  }
}
