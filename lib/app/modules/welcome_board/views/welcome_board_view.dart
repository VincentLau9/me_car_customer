import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_view.dart';
import 'package:me_car_customer/app/resources/assets_manager.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/routes/app_pages.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../controllers/welcome_board_controller.dart';

class WelcomeBoardView extends BaseView<WelcomeBoardController> {
  const WelcomeBoardView({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(children: [
          PageView(
            onPageChanged: (value) {
              controller.changePage(value);
            },
            controller: controller.pageController,
            scrollDirection: Axis.horizontal,
            children: [
              pageItem(ColorsManager.welcome2, ColorsManager.welcome2_2,
                  ImageAssets.welcomeBoard3, "Say some thing hi"),
              pageItem(ColorsManager.welcome3, ColorsManager.welcome3_3,
                  ImageAssets.welcomeBoard2, "Say some thing hi"),
              pageItem(ColorsManager.welcome1, ColorsManager.welcome1_1,
                  ImageAssets.welcomeBoard1, "Say some thing hi"),
            ],
          ),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: UtilsReponsive.height(context, 80),
                color: Colors.transparent,
                child: Obx(
                  () => controller.textNext.isFalse
                      ? Center(
                          child: TextButton(
                              onPressed: () {
                                Get.offAllNamed(Routes.SIGN_IN);
                              },
                              child: Text(
                                'Bắt đầu',
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: UtilsReponsive.width(context, 10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Get.offAllNamed(Routes.SIGN_IN);
                                  },
                                  child: Text(
                                    'Bỏ qua',
                                    style: TextStyle(color: Colors.white),
                                  )),
                              Center(
                                child: SmoothPageIndicator(
                                    controller: controller
                                        .pageController, // PageController
                                    count: 3,
                                    effect: ExpandingDotsEffect(
                                      dotColor: Colors.white,
                                      activeDotColor: Colors.green,
                                      spacing: 20,
                                    ),
                                    // your preferred effect
                                    onDotClicked: (index) {
                                      controller.pageController.animateToPage(
                                          index,
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.easeInOut);
                                    }),
                              ),
                              IconButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    controller.jumpToPage();
                                  },
                                  icon: Icon(Icons.arrow_forward))
                            ],
                          ),
                        ),
                ),
              ))
        ]),
      ),
    ));
  }

  Container pageItem(
      Color color1, Color color2, String pathImage, String textTitle) {
    return Container(
      child: Stack(
        children: [
          Column(children: [
            Expanded(
                child: Container(
              color: color1,
            )),
            Expanded(
                flex: 2,
                child: Container(
                  color: color2,
                ))
          ]),
          Positioned(
              top: UtilsReponsive.height(Get.context!, 134),
              right: 0,
              left: 0,
              child: Column(
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        pathImage,
                        fit: BoxFit.fitWidth,
                      )),
                  Text(textTitle,
                      style: TextStyle(color: Colors.white, fontSize: 32))
                ],
              ))
        ],
      ),
    );
  }
}
