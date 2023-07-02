import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_view.dart';
import 'package:me_car_customer/app/model/car.dart';
import 'package:me_car_customer/app/modules/common/components/form_field_widget.dart';
import 'package:me_car_customer/app/resources/assets_manager.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/resources/text_style.dart';
import 'package:me_car_customer/app/routes/app_pages.dart';

import '../controllers/update_firsttime_controller.dart';

class UpdateFirsttimeView extends BaseView<UpdateFirstTimeController> {
  const UpdateFirsttimeView({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        height: UtilsReponsive.height(context, 70),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(),
                              // IconButton(
                              //     onPressed: () {
                              //       Get.back();
                              //     },
                              //     icon: Icon(Icons.arrow_back))
                            ),
                            Expanded(
                              flex: 3,
                              child: _headerStep(),
                            ),
                            Expanded(
                              child: SizedBox(),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 9,
                        child: PageView(
                          onPageChanged: controller.changePage,
                          controller: controller.pageController,
                          children: [
                            _page1(context),
                            _page2(context),
                            _page3(context),
                          ],
                        ))
                  ],
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Obx(
                      () => controller.indexPage.value != 1
                          ? Container(
                              height: 80,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              child: ConstrainedBox(
                                constraints: BoxConstraints.tightFor(
                                    width: context.width),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                        ColorsManager.primary),
                                    // padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                                  ),
                                  child: Text(
                                    controller.indexPage.value != 2
                                        ? "Tiếp tục"
                                        : "Bắt đầu",
                                    style: TextStyleConstant.white16Roboto,
                                  ),
                                  onPressed: () {
                                    controller.indexPage.value != 2
                                        ? controller.jumpToPage()
                                        : controller.updateInfomation();
                                  },
                                ),
                              ),
                            )
                          : Container(
                              height: 160,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints.tightFor(
                                            width: context.width),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                            ),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    ColorsManager.primary),
                                            // padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                                          ),
                                          child: Text(
                                            "Thêm xe ngay",
                                            style:
                                                TextStyleConstant.white16Roboto,
                                          ),
                                          onPressed: () {
                                            Get.toNamed(Routes.CREATE_NEW_CAR);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints.tightFor(
                                            width: context.width),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color:
                                                        ColorsManager.primary),
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                            ),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            // padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                                          ),
                                          child: Obx(
                                            () => Text(
                                              controller.listCar.isEmpty
                                                  ? "Bỏ qua"
                                                  : "Tiếp tục",
                                              style: TextStyleConstant
                                                  .primary16Roboto,
                                            ),
                                          ),
                                          onPressed: () async {
                                            controller.jumpToPage();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ))
              ],
            ),
          ),
        ));
  }

  Container _page3(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: UtilsReponsive.width(context, 30),
          vertical: UtilsReponsive.height(context, 30)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Image.asset(
          ImageAssets.addCarImage,
          height: UtilsReponsive.height(context, 300),
          width: UtilsReponsive.height(context, 300),
        ),
        Text(
          "Hoàn thành",
          style: TextStyleConstant.black22RobotoBold,
        ),
        SizedBox(
          height: UtilsReponsive.height(context, 30),
        ),
        Text(
          "Chúc bạn có trải nghiệm tuyệt vời khi sử dụng ứng dụng",
          textAlign: TextAlign.center,
          style: TextStyleConstant.black16Roboto,
        ),
      ]),
    );
  }

  Container _page2(BuildContext context) {
    log(controller.listCar.length.toString());
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: UtilsReponsive.width(context, 30),
          vertical: UtilsReponsive.height(context, 30)),
      child: Obx(
        () => controller.listCar.isNotEmpty
            ? ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: controller.listCar.value.length,
                itemBuilder: (context, index) =>
                    itemCar(context, controller.listCar[index]),
              )
            : SingleChildScrollView(
                primary: false,
                scrollDirection: Axis.vertical,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageAssets.addCarImage,
                        height: UtilsReponsive.height(context, 300),
                        width: UtilsReponsive.height(context, 300),
                      ),
                      Text(
                        "Thêm Xe Mới",
                        style: TextStyleConstant.black22RobotoBold,
                      ),
                      SizedBox(
                        height: UtilsReponsive.height(context, 30),
                      ),
                      Text(
                        "Bạn sẽ được cung cấp các dịch vụ chuyên về chiếc xe của bạn",
                        textAlign: TextAlign.center,
                        style: TextStyleConstant.black16Roboto,
                      ),
                    ]),
              ),
      ),
    );
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
                    Text(
                      carModel.carBrand ?? "Khác",
                      style: TextStyleConstant.primary16RobotoBold,
                    ),
                  ],
                ),
                SizedBox()
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

  Container _page1(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: UtilsReponsive.height(context, 20),
          horizontal: UtilsReponsive.width(context, 23)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Thông tin cá nhân",
              style: TextStyleConstant.black22RobotoBold,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          RichText(
            text: new TextSpan(
              style: new TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                new TextSpan(text: 'Họ & tên'),
                new TextSpan(text: '*', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Obx(
            () => FormFieldWidget(
                padding: 10,
                initValue: controller.name.value,
                textInputType: TextInputType.text,
                labelText: "Nhập tên",
                errorText: controller.errNameInput.value,
                setValueFunc: controller.setValueName),
          ),
          SizedBox(
            height: 16,
          ),
          RichText(
            text: new TextSpan(
              style: new TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                new TextSpan(text: 'Email'),
                new TextSpan(text: '*', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Obx(
            () => Text(
              controller.email.value,
              style: TextStyleConstant.black16RobotoBold,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          RichText(
            text: new TextSpan(
              style: new TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                new TextSpan(text: 'Số điện thoại'),
                new TextSpan(text: '*', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Obx(
            () => FormFieldWidget(
                initValue: controller.phoneNumber.value,
                padding: 10,
                textInputType: TextInputType.number,
                labelText: "Nhập số điện thoại",
                errorText: controller.errPhoneInput.value,
                setValueFunc: controller.setValuePhone),
          ),
          SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }

  Container _headerStep() {
    return Container(
        child: Center(
      child: Obx(
        () => Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  controller.onTapChangePage(0);
                },
                child: CircleAvatar(
                  backgroundColor: ColorsManager.primary,
                  child: Text(
                    '1',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
              height: 3,
              width: double.infinity,
              color: controller.indexPage < 1
                  ? ColorsManager.primary.withOpacity(0.3)
                  : ColorsManager.primary,
            )),
            Expanded(
              child: InkWell(
                onTap: () {
                  controller.onTapChangePage(1);
                },
                child: CircleAvatar(
                  backgroundColor: controller.indexPage < 1
                      ? ColorsManager.primary.withOpacity(0.3)
                      : ColorsManager.primary,
                  child: Text(
                    '2',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
              height: 3,
              width: double.infinity,
              color: controller.indexPage < 2
                  ? ColorsManager.primary.withOpacity(0.3)
                  : ColorsManager.primary,
            )),
            Expanded(
              child: InkWell(
                onTap: () {
                  controller.onTapChangePage(2);
                },
                child: CircleAvatar(
                  backgroundColor: controller.indexPage < 2
                      ? ColorsManager.primary.withOpacity(0.3)
                      : ColorsManager.primary,
                  child: Text(
                    '3',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
