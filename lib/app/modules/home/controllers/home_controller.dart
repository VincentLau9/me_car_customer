import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_controller.dart';
import 'package:me_car_customer/app/modules/home/controllers/tab-booking-controller/tab_booking_list_controller.dart';
import 'package:me_car_customer/app/modules/home/controllers/tab-home-controller/tab_home_controller.dart';
import 'package:me_car_customer/app/modules/home/controllers/tab-service-controller/tab_service_controller.dart';
import 'package:me_car_customer/app/modules/home/views/tab-booking-view/tab_booking_list_view.dart';
import 'package:me_car_customer/app/modules/home/views/tab-profile-view/tab_profile_view.dart';
import 'package:me_car_customer/app/modules/home/views/tab-service-view/tab_service_view.dart';

import '../views/tab-home-view/tab_home_view.dart';

class HomeController extends BaseController {
  RxList<Widget> body = RxList([
    TabHomeView(),
    TabServiceView(),
    SizedBox(),
    TabBookingListView(),
    TabProfileView()
  ]);

  RxInt selectedIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  onTapped(int index) {
    switch (index) {
      case 0:
        Get.find<TabHomeController>();
        selectedIndex(0);
        break;
      case 1:
        Get.find<TabServiceController>();
        selectedIndex(1);
        break;
      case 2:
        // Get.find<TabNotificationController>();
        // selectedIndex(2);
        break;
      case 3:
        Get.find<TabBookingListController>();
        Get.find<TabBookingListController>().loadBooking(0);
        selectedIndex(3);
        break;
      case 4:
        // Get.find<TabProfileController>();
        selectedIndex(4);
        break;
      default:
    }
  }
}
