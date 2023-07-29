import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_view.dart';
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
              "Đã Hủy",
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
              children: [
                Material(
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
                          ListView.separated(
                            shrinkWrap: true,
                            itemCount: 10,
                            separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                            itemBuilder: (context, index) {
                              return _itemBooking(context);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                 Material(
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
                          ListView.separated(
                            shrinkWrap: true,
                            itemCount: 10,
                            separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                            itemBuilder: (context, index) {
                              return _itemBooking(context);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                 Material(
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
                          ListView.separated(
                            shrinkWrap: true,
                            itemCount: 10,
                            separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.BOOKING_DETAIL);
                                },
                                child: _itemBooking(context));
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                 Material(
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
                          ListView.separated(
                            shrinkWrap: true,
                            itemCount: 10,
                            separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                            itemBuilder: (context, index) {
                              return _itemBooking(context);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _itemBooking(BuildContext context) {
    return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        UtilsReponsive.width(context, 15),
                                    vertical:
                                        UtilsReponsive.height(context, 20)),
                                width: UtilsReponsive.width(context, 320),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.3)),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Stack(
                                  children: [
                                      
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Icon(Icons.more_vert)),
                                  Column(
                                    children: [
                                        Row(
                                      children: [
                                        SizedBox(
                                            width: UtilsReponsive.width(
                                                context, 70),
                                            height: UtilsReponsive.width(
                                                context, 63),
                                            child: Image.asset(
                                                'assets/images/Icon.png')),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: UtilsReponsive.width(
                                                  context, 10)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left:
                                                        UtilsReponsive.width(
                                                            context, 20)),
                                                child: Text('AUDI A5 2015'),
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
                                                    '23/01/2023 - 8:00 AM',
                                                  ),
                                                ],
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
                                                      'assets/images/clock.svg',
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Quận 6, Hồ Chí Minh',
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                       SizedBox(
                                                height: 20,
                                              ),
                                    Row(
                                      mainAxisAlignment:MainAxisAlignment.end,
                                      children: [
                                    Text('18,760,000 VNĐ',style:TextStyleConstant.primary16RobotoBold,)
                                      ],
                                    )
                                    ],
                                  )
                                  ],
                                ));
  }
}
