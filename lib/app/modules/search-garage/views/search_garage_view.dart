import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_view.dart';
import 'package:me_car_customer/app/model/garageDetail.dart';
import 'package:me_car_customer/app/modules/common/components/form_field_widget.dart';
import 'package:me_car_customer/app/modules/map-explore/views/detail_garage.dart';
import 'package:me_car_customer/app/resources/assets_manager.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/resources/text_style.dart';
import 'package:me_car_customer/app/routes/app_pages.dart';

import '../controllers/search_garage_controller.dart';

class SearchGarageView extends BaseView<SearchGarageController> {
  const SearchGarageView({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: UtilsReponsive.height(context, 120),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: Icon(Icons.arrow_back),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Center(
                                    child: Text(
                                  'Chọn chi nhánh',
                                  style: TextStyleConstant.black22RobotoBold,
                                )),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SvgPicture.asset(ImageAssets.filter_icon),
                                    Text(
                                      'Lọc',
                                      style: TextStyleConstant.primary14Roboto,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: UtilsReponsive.height(context, 5),
                                    horizontal:
                                        UtilsReponsive.width(context, 20)),
                                child: FormFieldWidget(
                                  padding: 10,
                                  setValueFunc: controller.searchGarage,
                                  labelText: 'Nhập từ khoá tìm kiếm',
                                )))
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 6,
                  child: Obx(
                    () => controller.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: controller.listGarage.value.length,
                            itemBuilder: (context, index) {
                              double km = (Geolocator.distanceBetween(
                                          controller.listGarage.value[index]
                                              .garageLatitude!,
                                          controller.listGarage.value[index]
                                              .garageLongitude!,
                                          controller.lat.value,
                                          controller.long.value) /
                                      1000)
                                  .toPrecision(1);
                              return GestureDetector(
                                onTap: () {
                                  controller.chooseGarage( controller.listGarage.value[index]);
                                },
                                child: Container(
                                  height:
                                      UtilsReponsive.height(Get.context!, 150),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey
                                                  .withOpacity(0.3)))),
                                  child: Column(children: [
                                    Expanded(
                                      flex: 5,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 8,
                                              child: ListTile(
                                                leading: Image.asset(
                                                  ImageAssets.logo,
                                                  fit: BoxFit.fill,
                                                  height: UtilsReponsive.height(
                                                      Get.context!, 80),
                                                  width: UtilsReponsive.height(
                                                      Get.context!, 80),
                                                ),
                                                title: Text(
                                                    controller
                                                            .listGarage
                                                            .value[index]
                                                            .garageName ??
                                                        "Null",
                                                    style: TextStyleConstant
                                                        .black16RobotoBold),
                                                subtitle: Text(
                                                    '${ controller
                                                            .listGarage
                                                            .value[index].rating}⭐️'),
                                              )),
                                          Expanded(
                                              child: IconButton(
                                                  onPressed: () {
                                                   Get.toNamed(Routes.GARAGE_DETAIL,arguments: GarageDetail(garageId:  controller
                                                          .listGarage
                                                          .value[index].garageId,km: km));
                                                  },
                                                  icon: Icon(
                                                      Icons.arrow_forward)))
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 8,
                                            left: UtilsReponsive.width(
                                                context, 20)),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: UtilsReponsive.width(
                                                  context, 20),
                                              height: UtilsReponsive.width(
                                                  context, 20),
                                              child: SvgPicture.asset(
                                                  'assets/images/location.svg'),
                                            ),
                                            SizedBox(
                                              width: UtilsReponsive.width(
                                                  context, 20),
                                            ),
                                            Text(
                                              controller.listGarage.value[index]
                                                      .garageAddress ??
                                                  'Null',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyleConstant
                                                  .black16Roboto,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 8,
                                            left: UtilsReponsive.width(
                                                context, 20)),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: UtilsReponsive.width(
                                                  context, 20),
                                              height: UtilsReponsive.width(
                                                  context, 20),
                                              child: SvgPicture.asset(
                                                  'assets/images/distance.svg'),
                                            ),
                                            SizedBox(
                                              width: UtilsReponsive.width(
                                                  context, 20),
                                            ),
                                            Text(
                                              '$km km',
                                              style: TextStyleConstant
                                                  .black16Roboto,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              );
                            },
                          ),
                  ))
            ],
          ),
        ));
  }
}
