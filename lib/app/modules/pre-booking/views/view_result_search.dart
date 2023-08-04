import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_view.dart';
import 'package:me_car_customer/app/modules/map-explore/views/detail_garage.dart';
import 'package:me_car_customer/app/modules/pre-booking/controllers/pre_booking_controller.dart';
import 'package:me_car_customer/app/resources/assets_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/resources/text_style.dart';

class ViewResultSearch extends BaseView<PreBookingController> {
  const ViewResultSearch({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              'Kết quả tìm kiếm',
              style: TextStyleConstant.black22RobotoBold,
            )),
          ),
          Expanded(child: SizedBox())
        ],
      )),
      Expanded(
        flex: 9,
        child: Column(
          children: [
            Expanded(
                flex: 7,
                child: Obx(
                  () => controller.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: controller.listGarage.value.length,
                          itemBuilder: (context, index) {
                            double km = 0.0;
                            try {
                              km = (Geolocator.distanceBetween(
                                          controller.listGarage.value[index]
                                              .garageLatitude!,
                                          controller.listGarage.value[index]
                                              .garageLongitude!,
                                          controller.modelSearch.value.lat!,
                                          controller.modelSearch.value.lng!) /
                                      1000)
                                  .toPrecision(1);
                            } catch (e) {}
                            return GestureDetector(
                              onTap: () {
                                // Get.back();
                                controller.chooseGarage( controller.listGarage.value[index]);
                              },
                              child: Container(
                                height:
                                    UtilsReponsive.height(Get.context!, 150),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        bottom: BorderSide(
                                            color:
                                                Colors.grey.withOpacity(0.3)))),
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
                                              leading: CachedNetworkImage(
                                                fit: BoxFit.fill,
                                                height: UtilsReponsive.height(
                                                    Get.context!, 80),
                                                width: UtilsReponsive.height(
                                                    Get.context!, 80),
                                                imageUrl: controller.listGarage
                                                    .value[index].garageImage!,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Image.asset(
                                                  ImageAssets.logo,
                                                  fit: BoxFit.fill,
                                                  height: UtilsReponsive.height(
                                                      Get.context!, 80),
                                                  width: UtilsReponsive.height(
                                                      Get.context!, 80),
                                                ),
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              ),
                                              // controller.listGarage.value[index].garageImage==null|| controller.listGarage.value[index].garageImage!.isEmpty?
                                              //  Image.asset(
                                              //   ImageAssets.logo,
                                              //   fit: BoxFit.fill,
                                              //   height: UtilsReponsive.height(
                                              //       Get.context!, 80),
                                              //   width: UtilsReponsive.height(
                                              //       Get.context!, 80),
                                              // ): Image.network(
                                              //   controller.listGarage.value[index].garageImage!,
                                              //   fit: BoxFit.fill,
                                              //   height: UtilsReponsive.height(
                                              //       Get.context!, 80),
                                              //   width: UtilsReponsive.height(
                                              //       Get.context!, 80),
                                              // ),
                                              title: Text(
                                                  controller
                                                          .listGarage
                                                          .value[index]
                                                          .garageName ??
                                                      "Null",
                                                  style: TextStyleConstant
                                                      .black16RobotoBold),
                                              subtitle: Text(
                                                  '⭐️ ${controller.listGarage.value[index].rating}'),
                                            )),
                                        Expanded(
                                            child: IconButton(
                                                onPressed: () {
                                                  Get.to(DetailGarage(
                                                      garageModel: controller
                                                          .listGarage
                                                          .value[index]));
                                                },
                                                icon:
                                                    Icon(Icons.info)))
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
                                            style:
                                                TextStyleConstant.black16Roboto,
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
                                            style:
                                                TextStyleConstant.black16Roboto,
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
                )),
          ],
        ),
      )
    ])));
  }
}
