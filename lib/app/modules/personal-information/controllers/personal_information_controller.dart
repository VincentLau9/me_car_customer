import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_controller.dart';

class PersonalInformationController extends BaseController {
  //TODO: Implement HomeController

  final count = 0.obs;
  final isLoading = true.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    // await UserApi.getProfile(Get.find<StartAppController>().userId.value);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
