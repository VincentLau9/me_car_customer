import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_bindings.dart';

import '../controllers/coupon_view_controller.dart';

class CouponViewBinding extends BaseBindings {
  @override
  void injectService() {
    int garageId = Get.arguments as int;
    Get.lazyPut<CouponViewController>(
      () => CouponViewController(garageId: garageId),
    );
  }
}
