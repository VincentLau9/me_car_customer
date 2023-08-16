import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:me_car_customer/app/api/garage_api.dart';
import 'package:me_car_customer/app/base/base_controller.dart';
import 'package:me_car_customer/app/model/coupon.dart';
import 'package:me_car_customer/app/modules/booking-step/controllers/booking_step_controller.dart';

class CouponViewController extends BaseController {
  //TODO: Implement CouponViewController
  CouponViewController({required this.garageId});
  final garageId;
  final count = 0.obs;
  Rx<bool> isLoading = true.obs;
  RxList<Coupon> listCoupon = <Coupon>[].obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      await getAllCoupon(garageId);
      isLoading(false);
    } catch (e) {
      Get.back();
      Get.snackbar('Thông báo', 'Dữ liệu mã giảm giá trống',
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white);
    } finally {
      isLoading(false);
    }
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
  getAllCoupon(int idGarage) async {
    listCoupon.value = await GarageApi.getCoupon(idGarage);
  }

  chooseCoupon(Coupon coupon) async {
   await Get.find<BookingStepController>().chooseCoupon(coupon);
    Get.back();
  }
}
