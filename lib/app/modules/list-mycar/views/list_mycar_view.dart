import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_view.dart';
import 'package:me_car_customer/app/model/car.dart';
import 'package:me_car_customer/app/modules/booking-step/controllers/booking_step_controller.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/resources/text_style.dart';
import 'package:me_car_customer/app/routes/app_pages.dart';

import '../controllers/list_mycar_controller.dart';

class ListMycarView extends BaseView<ListMycarController> {
  const ListMycarView({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
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
              'Phương Tiện Của Tôi',
              style: TextStyleConstant.black22RobotoBold,
            )),
          ),
          Expanded(
              child: Get.isRegistered<BookingStepController>()
                  ? SizedBox()
                  : IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.CREATE_NEW_CAR);
                      },
                      icon: Icon(Icons.add)))
        ],
      )),
      Expanded(
          flex: 9,
          child: Obx(() => controller.isLoading.value
              ? Center(
                  child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: ColorsManager.primary,
                  ),
                ))
              : controller.listCar.value.isNotEmpty
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: UtilsReponsive.width(context, 15)),
                        child: Column(
                          children: [
                            ListView.separated(
                              primary: false,
                              separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                              // physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.listCar.value.length,
                              itemBuilder: (context, index) => GestureDetector(
                                  onTap: () => controller.chooseCar(index),
                                  child: itemCar(context,
                                      controller.listCar.value[index])),
                            )
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        'Danh sách xe trống',
                        style: TextStyleConstant.black22RobotoBold,
                      ),
                    )))
    ])));
  }

  Container itemCar(BuildContext context, Car carModel) {
    return Container(
      padding: EdgeInsets.all(UtilsReponsive.height(context, 15)),
      height: UtilsReponsive.height(context, 200),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: ColorsManager.primary)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.car_crash,
                      color: ColorsManager.primary,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      carModel.carBrand ?? "Khác",
                      style: TextStyleConstant.primary16RobotoBold,
                    ),
                  ],
                ),
                carModel.carStatus == "NotAvailable"
                    ? Container(
                        padding: EdgeInsets.all(10),
                        child: Text("Đang lên đơn",
                            style: TextStyleConstant.white14Roboto),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.amber.shade900),
                      )
                    : SizedBox()
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: UtilsReponsive.height(context, 5)),
              height: 0.5,
              width: double.infinity,
              color: Colors.grey,
            ),
            RichText(
              text: new TextSpan(
                children: <TextSpan>[
                  new TextSpan(
                      text: 'Biển số xe:  ',
                      style: TextStyleConstant.black16Roboto),
                  new TextSpan(
                      text: '${carModel.carLicensePlate}',
                      style: TextStyleConstant.black16RobotoBold),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              text: new TextSpan(
                children: <TextSpan>[
                  new TextSpan(
                      text: 'Loại xe:  ',
                      style: TextStyleConstant.black16Roboto),
                  new TextSpan(
                      text:
                          '${carModel.numberOfCarLot} chỗ - ${carModel.carFuelType}',
                      style: TextStyleConstant.black16RobotoBold),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              text: new TextSpan(
                children: <TextSpan>[
                  new TextSpan(
                      text: 'Nhiên liệu xe:  ',
                      style: TextStyleConstant.black16Roboto),
                  new TextSpan(
                      text: '${carModel.carFuelType}',
                      style: TextStyleConstant.black16RobotoBold),
                ],
              ),
            )
          ]),
    );
  }
}
