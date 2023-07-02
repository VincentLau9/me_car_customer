import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_bindings.dart';

import '../controllers/welcome_board_controller.dart';

class WelcomeBoardBinding extends BaseBindings {
  @override
  void injectService() {
    Get.lazyPut<WelcomeBoardController>(
      () => WelcomeBoardController(),
    );
  }
}
