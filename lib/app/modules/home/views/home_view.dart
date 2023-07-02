
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:me_car_customer/app/base/base_view.dart';
import 'package:line_icons/line_icons.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/resources/text_style.dart';
import 'package:me_car_customer/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends BaseView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: Container(
          height: UtilsReponsive.height(context, 60),
          width: UtilsReponsive.height(context, 60),
          child: FloatingActionButton(
              backgroundColor: ColorsManager.primary,
              onPressed: () async {
                LocationPermission permission =
                    await Geolocator.checkPermission();
                if (permission == LocationPermission.denied) {
                  permission = await Geolocator.requestPermission();
                  if (permission == LocationPermission.denied) {
                  } else {
                    Get.toNamed(Routes.MAP_EXPLORE);
                  }
                } else {
                  Get.toNamed(Routes.MAP_EXPLORE);
                }
              },
              child: Icon(Icons.add)),
        ),
        bottomNavigationBar:Obx(() =>  _bottomNav(context)),
        body: Obx(
            () => controller.body.elementAt(controller.selectedIndex.value)));
  }

  Container _bottomNav(BuildContext context) {
    return Container(
        height: UtilsReponsive.height(context, 80),
        padding: EdgeInsets.only(bottom: UtilsReponsive.height(context, 15)),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: LineIcon(LineIcons.home),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: LineIcon(Icons.car_repair),
              label: 'Dịch vụ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.abc),
              label: 'Đặt lịch',
            ),
            BottomNavigationBarItem(
              icon: LineIcon(Icons.note),
              label: 'Đơn hàng',
            ),
            BottomNavigationBarItem(
              icon: LineIcon(Icons.person),
              label: 'Tài khoản',
            ),
          ],
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: ColorsManager.primary,
          selectedLabelStyle: TextStyleConstant.primary14RobotoBold,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: TextStyleConstant.primary14Roboto,
          showUnselectedLabels: true,
          elevation: 0,
          onTap: controller.onTapped,
        ));
  }
}
