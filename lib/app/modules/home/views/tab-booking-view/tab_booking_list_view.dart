import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_view.dart';
import 'package:me_car_customer/app/model/booking.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/resources/text_style.dart';
import 'package:me_car_customer/app/routes/app_pages.dart';

import '../../controllers/tab-booking-controller/tab_booking_list_controller.dart';

class TabBookingListView extends BaseView<TabBookingListController> {
  const TabBookingListView({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TabBar createTabBar() {
      return TabBar(
        onTap: (value) async {
          await controller.loadBooking(value);
        },
        indicatorColor: ColorsManager.primary,
        labelPadding: const EdgeInsets.all(10),
        tabs: [
          SizedBox(
            width: size.width * 0.5,
            child: const Text(
              textAlign: TextAlign.center,
              "Sắp tới",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.5,
            child: const Text(
              textAlign: TextAlign.center,
              "Đang thực hiện",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.5,
            child: const Text(
              textAlign: TextAlign.center,
              "Hoành thành",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.5,
            child: const Text(
              textAlign: TextAlign.center,
              "Đã Hủy",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
        ],
        isScrollable: true,
      );
    }

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text(
            "Lịch Sử Đặt Lịch",
          ),
          titleTextStyle: TextStyle(
            fontSize: size.height * 0.028,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          bottom: createTabBar(),
        ),
        body: Material(
          child: Container(
            color: Colors.white,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                Obx(
                  () => controller.isLoading.value
                      ? Center(
                          child: SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator()))
                      : Material(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: UtilsReponsive.width(context, 15)),
                            color: Colors.white,
                            width: size.width,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: size.height * 0.03,
                                  ),
                                  controller.listBooking.value.isEmpty
                                      ? Center(child: Text('Danh sách trống'))
                                      : ListView.separated(
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount: controller
                                              .listBooking.value.length,
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                            height: 10,
                                          ),
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Get.toNamed(
                                                    Routes.BOOKING_DETAIL,
                                                    arguments: controller
                                                        .listBooking[index]
                                                        .bookingId);
                                              },
                                              child: _itemBooking(
                                                  context,
                                                  controller
                                                      .listBooking[index]),
                                            );
                                          },
                                        )
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
                Obx(
                  () => controller.isLoading.value
                      ? Center(
                          child: SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator()))
                      : Material(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: UtilsReponsive.width(context, 15)),
                            color: Colors.white,
                            width: size.width,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: size.height * 0.03,
                                  ),
                                  controller.listBooking.value.isEmpty
                                      ? Center(child: Text('Danh sách trống'))
                                      : ListView.separated(
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount: controller
                                              .listBooking.value.length,
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                            height: 10,
                                          ),
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Get.toNamed(
                                                    Routes.BOOKING_DETAIL,
                                                    arguments: controller
                                                        .listBooking[index]
                                                        .bookingId);
                                              },
                                              child: _itemBooking(
                                                  context,
                                                  controller
                                                      .listBooking[index]),
                                            );
                                          },
                                        )
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
                Obx(
                  () => controller.isLoading.value
                      ? Center(
                          child: SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator()))
                      : Material(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: UtilsReponsive.width(context, 15)),
                            color: Colors.white,
                            width: size.width,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: size.height * 0.03,
                                  ),
                                  controller.listBooking.value.isEmpty
                                      ? Center(child: Text('Danh sách trống'))
                                      : ListView.separated(
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount: controller
                                              .listBooking.value.length,
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                            height: 10,
                                          ),
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                                onTap: () {
                                                  Get.toNamed(
                                                      Routes.BOOKING_DETAIL,
                                                      arguments: controller
                                                          .listBooking[index]
                                                          .bookingId);
                                                },
                                                child: _itemBooking(
                                                    context,
                                                    controller
                                                        .listBooking[index]));
                                          },
                                        )
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
                Obx(
                  () => controller.isLoading.value
                      ? Center(
                          child: SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator()))
                      : Material(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: UtilsReponsive.width(context, 15)),
                            color: Colors.white,
                            width: size.width,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: size.height * 0.03,
                                  ),
                                  controller.listBooking.value.isEmpty
                                      ? Center(child: Text('Danh sách trống'))
                                      : ListView.separated(
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount: controller
                                              .listBooking.value.length,
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                            height: 10,
                                          ),
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Get.toNamed(
                                                    Routes.BOOKING_DETAIL,
                                                    arguments: controller
                                                        .listBooking[index]
                                                        .bookingId);
                                              },
                                              child: _itemBooking(
                                                  context,
                                                  controller
                                                      .listBooking[index]),
                                            );
                                          },
                                        )
                                ],
                              ),
                            ),
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _itemBooking(BuildContext context, Booking booking) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: UtilsReponsive.width(context, 15),
            vertical: UtilsReponsive.height(context, 20)),
        width: UtilsReponsive.width(context, 320),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            Positioned(top: 0, right: 0, child: Icon(Icons.more_vert)),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: UtilsReponsive.width(context, 70),
                        height: UtilsReponsive.width(context, 63),
                        child: Image.asset('assets/images/Icon.png'),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: UtilsReponsive.width(context, 10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: UtilsReponsive.width(context, 20)),
                              child: Text(booking.carName!),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 14,
                                  height: 14,
                                  child: SvgPicture.asset(
                                    'assets/images/location.svg',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  booking.bookingTime!,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 14,
                                    height: 14,
                                    child: SvgPicture.asset(
                                      'assets/images/clock.svg',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Text(
                                      booking.garageAddress!,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      booking.price!,
                      style: TextStyleConstant.primary16RobotoBold,
                    )
                  ],
                )
              ],
            )
          ],
        ));
  }
}
