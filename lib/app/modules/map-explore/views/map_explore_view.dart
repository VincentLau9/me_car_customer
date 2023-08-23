import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:me_car_customer/app/base/base_view.dart';
import 'package:me_car_customer/app/modules/map-explore/views/search_address_screen.dart';
import 'package:me_car_customer/app/resources/assets_manager.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/resources/text_style.dart';
import 'package:me_car_customer/app/routes/app_pages.dart';

import '../controllers/map_explore_controller.dart';

class MapExploreView extends BaseView<MapExploreController> {
  const MapExploreView({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    log(controller.listMarker.value.length.toString());
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Obx(
              () => controller.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: ColorsManager.primary,
                      ),
                    )
                  : GoogleMap(
                      myLocationEnabled: true,
                      onMapCreated: controller.onMapCreated,
                      markers: Set.from(controller.listMarker.value),
                      zoomControlsEnabled: false,
                      initialCameraPosition: CameraPosition(
                          zoom: 16,
                          target: LatLng(
                              controller.lat.value, controller.lng.value))),
            ),
            Align(
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
                              'Chọn đại lý',
                              style: TextStyleConstant.black22RobotoBold,
                            )),
                          ),
                          Expanded(
                            child:SizedBox()
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: UtilsReponsive.height(context, 5),
                          horizontal: UtilsReponsive.width(context, 20)),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(SearchAddressPage());
                        },
                        child: Container(
                          padding: EdgeInsetsDirectional.all(
                              UtilsReponsive.width(context, 15)),
                          height: UtilsReponsive.height(context, 20),
                          width: double.infinity,
                          child: Obx(() => Text(
                                '${controller.textSearch.value.isEmpty ? "Tìm kiếm" : controller.textSearch.value}',
                                overflow: TextOverflow.ellipsis,
                              )),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: UtilsReponsive.height(context, 30),
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: ColorsManager.primary,
                          borderRadius: BorderRadius.circular(5)),
                      height: UtilsReponsive.height(context, 30),
                      width: UtilsReponsive.width(context, 70),
                      child: Center(child: Text('Bản đồ',style: TextStyleConstant.white14Roboto)),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.SEARCH_GARAGE,arguments:false);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: ColorsManager.primary.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5)),
                        height: UtilsReponsive.height(context, 30),
                        width: UtilsReponsive.width(context, 70),
                        child: Center(child: Text('Danh sách',style: TextStyleConstant.white14Roboto)),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
