import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:line_icons/line_icons.dart';

import 'package:me_car_customer/app/base/base_view.dart';
import 'package:me_car_customer/app/model/garage.dart';
import 'package:me_car_customer/app/modules/common/components/form_field_widget.dart';
import 'package:me_car_customer/app/modules/start_app/controllers/start_app_controller.dart';
import 'package:me_car_customer/app/resources/assets_manager.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/resources/text_style.dart';
import 'package:me_car_customer/app/routes/app_pages.dart';

import '../../controllers/tab-home-controller/tab_home_controller.dart';

class TabHomeView extends BaseView<TabHomeController> {
  const TabHomeView({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(top: 0, right: 0, child: Image.asset(ImageAssets.elip1)),
          Positioned(bottom: 0, left: 0, child: Image.asset(ImageAssets.elip2)),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: UtilsReponsive.width(context, 10),
                vertical: UtilsReponsive.height(context, 30)),
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Image.asset(
                              ImageAssets.logo,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Xin chào,',
                                  style: TextStyleConstant.black16RobotoBold,
                                ),
                                Text(
                                    Get.find<StartAppController>()
                                            .userModelT
                                            .value
                                            .userFullName ??
                                        "Bạn",
                                    style: TextStyleConstant.black16RobotoBold)
                              ],
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                                onPressed: () async {
                                  
                                },
                                icon: Icon(Icons.notifications)),
                          )
                        ],
                      ),
                    )),
                Expanded(
                    child: Container(
                  child: FormFieldWidget(
                      isEnabled: false,
                      padding: 10,
                      icon: Icon(Icons.search),
                      textInputType: TextInputType.text,
                      labelText: "Tìm kiếm",
                      suffixIcon: Icon(Icons.filter_alt),
                      setValueFunc: () {}),
                )),
                Expanded(flex: 2, child: _listItemIconHome()),
                Expanded(
                    flex: 2,
                    child: Container(
                        child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: UtilsReponsive.height(context, 10)),
                          color: Colors.grey,
                          height: 0.5,
                          width: double.infinity,
                        ),
                        Container(
                          height: UtilsReponsive.height(context, 75),
                          width: double.infinity,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Container(
                                  height: UtilsReponsive.height(context, 75),
                                  child: Card(
                                      child: Image.asset(ImageAssets.card))),
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 5,
                                  ),
                              itemCount: 5),
                        )
                      ],
                    ))),
                Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Các dịch vụ nổi bật',
                                style: TextStyleConstant.black22RobotoBold,
                              ),
                              Text(
                                'Tất cả',
                                style: TextStyleConstant.primary14RobotoBold,
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: 5,
                            separatorBuilder: (context, index) => SizedBox(
                              height: 8,
                            ),
                            itemBuilder: (context, index) => Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white60,
                                  borderRadius: BorderRadius.circular(15)),
                              height: UtilsReponsive.height(context, 110),
                              width: UtilsReponsive.width(context, 150),
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 5.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Image.asset(
                                                  ImageAssets.card)),
                                          Expanded(
                                              child: ListTile(
                                            title: Text('Thay thế phụ tùng'),
                                            subtitle: Text('4.8 ⭐️'),
                                          ))
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                side: BorderSide(
                                                    color:
                                                        ColorsManager.primary),
                                              ),
                                              backgroundColor: Colors.white,
                                            ),
                                            child: Text("Chi tiết",
                                                style: TextStyleConstant
                                                    .primary14Roboto),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: ElevatedButton(
                                            onPressed: () {
                                               Get.toNamed(Routes.BOOKING_STEP,
                                                arguments: GarageModel(
                                                  garageId: 1,
                                                  garageAddress:
                                                      'Quận 9 Hồ Chí Minh',
                                                  garageName: 'Garage mơ ước',
                                                ));
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                side: BorderSide(
                                                    color: ColorsManager
                                                        .primary),
                                              ),
                                              backgroundColor:
                                                  ColorsManager.primary,
                                            ),
                                            child: const Text("Đặt lịch"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    ));
  }

  Padding _listItemIconHome() {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              'Danh mục',
              style: TextStyleConstant.black22RobotoBold,
            ),
          ),
          Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        LocationPermission permission =
                            await Geolocator.checkPermission();
                        if (permission == LocationPermission.denied) {
                          permission = await Geolocator.requestPermission();
                          if (permission == LocationPermission.denied) {
                          } else {
                            Get.toNamed(Routes.SEARCH_GARAGE, arguments: true);
                          }
                        } else {
                          Get.toNamed(Routes.SEARCH_GARAGE, arguments: true);
                        }
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                              backgroundColor: ColorsManager.colorIconHome,
                              child:
                                  SvgPicture.asset('assets/images/daily.svg')),
                          Text(
                            'Đại lý',
                            style: TextStyleConstant.black16RobotoBold,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        CircleAvatar(
                            backgroundColor: ColorsManager.colorIconHome,
                            child: Icon(
                              Icons.calendar_month,
                              color: ColorsManager.primary,
                            )),
                        Text(
                          'Đặt lịch\ndịch vụ',
                          textAlign: TextAlign.center,
                          style: TextStyleConstant.black16RobotoBold,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.BOOKING_INPROGRESS);
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                              backgroundColor: ColorsManager.colorIconHome,
                              child:
                                  SvgPicture.asset('assets/images/time.svg')),
                          Text(
                            'Đơn hàng\ncủa tôi',
                            textAlign: TextAlign.center,
                            style: TextStyleConstant.black16RobotoBold,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.LIST_MYCAR, arguments: true);
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                              backgroundColor: ColorsManager.colorIconHome,
                              child: SvgPicture.asset('assets/images/car.svg')),
                          Text(
                            'Xe của tôi',
                            style: TextStyleConstant.black16RobotoBold,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
