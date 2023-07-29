import 'dart:developer';

import 'package:flutter/Material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:me_car_customer/app/api/garage_api.dart';
import 'package:me_car_customer/app/base/base_controller.dart';
import 'package:me_car_customer/app/model/data_search_model.dart';
import 'package:me_car_customer/app/model/garage.dart';
import 'package:me_car_customer/app/modules/map-explore/views/detail_garage.dart';
import 'package:me_car_customer/app/resources/assets_manager.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/resources/text_style.dart';
import 'package:me_car_customer/app/routes/app_pages.dart';

class MapExploreController extends BaseController {
  //TODO: Implement MapExploreController

  final count = 0.obs;
  Rx<DataSearchModel> modelSearch = DataSearchModel().obs;
  Rx<double> lat = 0.0.obs;
  Rx<double> lng = 0.0.obs;
  Rx<String> textSearch = ''.obs;
  late GoogleMapController mapController;
  RxList<Marker> listMarker = <Marker>[].obs;
  Rx<bool> isLoading =true.obs;
  @override
  Future<void> onInit() async {
    
  Position curentPosition =await Geolocator.getCurrentPosition();
  lat(curentPosition.latitude);
  lng(curentPosition.longitude);
    await updateListMarker();

   isLoading.value=false;
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

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void updateMapCamera(double lat, double long) async {
    mapController.animateCamera(CameraUpdate.newLatLng(LatLng(lat, long)));
    // await GarageApi.searchGarage(lat, long);
  }

  updateListMarker() async {
    try {
      List<GarageModel> listGarage = await GarageApi.searchGarage(lat.value, lng.value);

      listGarage.forEach((element) {
        double km = (Geolocator.distanceBetween(
                    element.garageLatitude!,
                    element.garageLongitude!,
                    lat.value,
                    lng.value) /
                1000)
            .toPrecision(1);

        listMarker.add(Marker(
          infoWindow: InfoWindow(title: '${element.garageName}'),
          markerId: MarkerId(element.garageId.toString()),
          position: LatLng(element.garageLatitude!, element.garageLongitude!),
          onTap: () {
            Get.bottomSheet(
                Container(
                  height: UtilsReponsive.height(Get.context!, 200),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              UtilsReponsive.height(Get.context!, 30)),
                          topRight: Radius.circular(
                              UtilsReponsive.height(Get.context!, 30)))),
                  child: Column(children: [
                    Container(
                      height: 5,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      color: Colors.grey,
                      width: UtilsReponsive.width(Get.context!, 50),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 8,
                              child: ListTile(
                                leading: Image.asset(
                                  ImageAssets.logo,
                                  fit: BoxFit.fill,
                                  height:
                                      UtilsReponsive.height(Get.context!, 80),
                                  width:
                                      UtilsReponsive.height(Get.context!, 80),
                                ),
                                title: Text('${element.garageName}',
                                    style: TextStyleConstant.black16RobotoBold),
                                subtitle: Text(
                                    '⭐️${element.rating} | ${element.garageDistrict}'),
                              )),
                          Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    Get.to(DetailGarage(garageModel: element));
                                  },
                                  icon: Icon(Icons.arrow_forward)))
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Khuyến mãi (0)',
                              style: TextStyleConstant.primary14Roboto,
                            ),
                            Text(
                              '${km} km',
                              style: TextStyleConstant.primary14Roboto,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            log('message');
                            Get.toNamed(Routes.BOOKING_STEP,arguments: element);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    UtilsReponsive.width(Get.context!, 80)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: ColorsManager.primary),
                            ),
                            backgroundColor: ColorsManager.primary,
                          ),
                          child: Text("Đặt lịch",
                              style: TextStyleConstant.white16Roboto),
                        ),
                      ),
                    ),
                  ]),
                ),
                barrierColor: Colors.transparent);
          },
        ));
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
