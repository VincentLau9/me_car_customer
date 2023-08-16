import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_view.dart';
import 'package:me_car_customer/app/resources/assets_manager.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/resources/text_style.dart';
import 'package:me_car_customer/app/routes/app_pages.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../controllers/booking_service_status_controller.dart';

class BookingServiceStatusView
    extends BaseView<BookingServiceStatusController> {
  const BookingServiceStatusView({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(
              horizontal: UtilsReponsive.width(context, 40),
              vertical: UtilsReponsive.height(context, 20)),
          height: UtilsReponsive.height(context, 90),
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: context.width),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: ColorsManager.primary)),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                padding: MaterialStateProperty.all(EdgeInsets.all(14)),
              ),
              child: Text(
                "Về trang chủ",
                style: TextStyleConstant.primary16RobotoBold,
              ),
              onPressed: () async {
                Get.offAllNamed(Routes.HOME);
              },
            ),
          ),
        ),
        body: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            flex: 4,
                            child: Center(
                                child: Text(
                              'Tiến trình',
                              style: TextStyleConstant.black22RobotoBold,
                            )),
                          ),
                          Expanded(child: SizedBox())
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              flex: 9,
              child: Obx(() => controller.isLoading.value
                  ? Center(
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : SingleChildScrollView(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Thợ phụ trách",
                              style: TextStyleConstant.black18RobotoBold),
                          SizedBox(
                            height: 15,
                          ),
                          Obx(() => controller.listMechaic.isEmpty?Text("Đơn hàng chưa được phân bổ cho thợ")
                          :
                          Container(
                              height: UtilsReponsive.height(context, 100),
                              width: double.infinity,
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                primary: false,
                                itemCount: controller.listMechaic.length,
                                separatorBuilder: (context, index) => SizedBox(
                                  width: 10,
                                ),
                                itemBuilder: (context, index) => Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          UtilsReponsive.width(context, 15),
                                      vertical:
                                          UtilsReponsive.width(context, 5)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        Colors.white, // Màu nền của container
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(
                                            0.5), // Màu của đổ bóng
                                        spreadRadius: 0.5, // Độ dài của đổ bóng
                                        blurRadius: 7, // Độ mờ của đổ bóng
                                        offset: Offset(
                                            0, 3), // Độ tịnh tiến của đổ bóng
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      ClipOval(
                                        child: CachedNetworkImage(
                                          height: UtilsReponsive.height(
                                              context, 50),
                                          width: UtilsReponsive.height(
                                              context, 50),
                                          imageUrl: controller
                                                  .listMechaic[index].image ??
                                              "",
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              SvgPicture.asset(IconAssets.user),
                                        ),
                                      ),
                                      Text(controller
                                          .listMechaic[index].fullName
                                          .toString()),
                                      controller.listMechaic[index]
                                              .isMainMechanic!
                                          ? Text("(Thợ chính)")
                                          : SizedBox.shrink()
                                    ],
                                  ),
                                ),
                              )),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text("Dịch vụ đã đặt",
                              style: TextStyleConstant.black18RobotoBold),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white, // Màu nền của container
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.5), // Màu của đổ bóng
                                  spreadRadius: 2, // Độ dài của đổ bóng
                                  blurRadius: 7, // Độ mờ của đổ bóng
                                  offset:
                                      Offset(0, 3), // Độ tịnh tiến của đổ bóng
                                ),
                              ],
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              primary: false,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.listData.length,
                              separatorBuilder: (context, index) => SizedBox(
                                height: 15,
                              ),
                              itemBuilder: (context, index) => Row(
                                children: [
                                  SvgPicture.asset(controller.getPathStatus(
                                      controller.listData.value[index]
                                          .bookingServiceStatus
                                          .toString())),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    controller.listData.value[index].serviceName
                                        .toString(),
                                    style: TextStyleConstant.black14RobotoBold,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Lịch trình",
                              style: TextStyleConstant.black18RobotoBold),
                          SizedBox(
                            height: 15,
                          ),
                          ListView.builder(
                            padding: EdgeInsets.all(0),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.listData.length,
                            itemBuilder: (context, index) {
                              return TimelineTile(
                                lineXY: 0.05,
                                alignment: TimelineAlign.manual,
                                // lineX: 0.3,
                                isFirst: index == 0,
                                isLast: index == controller.listData.length ,
                                indicatorStyle: IndicatorStyle(
                                  height: 17,
                                  width: 17,
                                  color: Colors.grey.withOpacity(0.5),
                                  indicatorXY: 0.15,
                                  // Màu lõi
                                  iconStyle: IconStyle(
                                    color: Colors.white, // Màu viền
                                    iconData: Icons.circle, // Loại biểu tượng
                                  ),
                                ),
                                beforeLineStyle: const LineStyle(
                                  color: Colors.grey,
                                  thickness: 2,
                                ),
                                endChild: Container(
                                  clipBehavior: Clip.hardEdge,
                                  height: UtilsReponsive.height(context, 100),
                                  width: 5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        Colors.white, // Màu nền của container
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(
                                            0.5), // Màu của đổ bóng
                                        spreadRadius: 2, // Độ dài của đổ bóng
                                        blurRadius: 7, // Độ mờ của đổ bóng
                                        offset: Offset(
                                            0, 3), // Độ tịnh tiến của đổ bóng
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        color: controller.getColorStatus(
                                            controller.listData.value[index]
                                                .bookingServiceStatus
                                                .toString()),
                                        height: double.infinity,
                                        width: 10,
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.listData.value[index]
                                                  .serviceName
                                                  .toString(),
                                              style: TextStyleConstant
                                                  .black14RobotoBold,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              controller.listData.value[index]
                                                      .updatedAt ??
                                                  "",
                                              style: TextStyleConstant
                                                  .black14RobotoBold,
                                            ),
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: UtilsReponsive.height(context, 90),
                          )
                        ],
                      ),
                    )))
        ])));
  }
}
