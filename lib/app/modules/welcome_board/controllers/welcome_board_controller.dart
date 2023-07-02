import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_controller.dart';

class WelcomeBoardController extends BaseController {
  //TODO: Implement WelcomeBoardController

  final count = 0.obs;
  PageController pageController = PageController();
  RxInt indexPage = 0.obs;
  RxBool textNext = true.obs;
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

  void jumpToPage() {
    if (indexPage.value + 1 < 3) {
      indexPage++;
      pageController.animateToPage(indexPage.value,duration: Duration(milliseconds: 500),curve: Curves.easeInOut);
    }
  }

  void changePage(int value) {
    if (value == 2) {
      textNext(false);
    } else {
      textNext(true);
    }
    indexPage.value = value;
  }
}
