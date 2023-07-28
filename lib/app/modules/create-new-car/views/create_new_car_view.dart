import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:me_car_customer/app/base/base_view.dart';
import 'package:me_car_customer/app/modules/booking-step/controllers/booking_step_controller.dart';
import 'package:me_car_customer/app/modules/common/components/form_field_widget.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/resources/text_style.dart';

import '../controllers/create_new_car_controller.dart';

class CreateNewCarView extends BaseView<CreateNewCarController> {
  const CreateNewCarView({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        bottomSheet: Container(
          margin: EdgeInsets.only(bottom: UtilsReponsive.height(context, 10)),
          padding: EdgeInsets.symmetric(
              horizontal: UtilsReponsive.width(context, 25)),
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: context.width),
            child: Obx(
              () => ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                      controller.enableButton.value
                          ? ColorsManager.primary
                          : Colors.grey),
                  padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                ),
                child: controller.lockButton.value
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        "Thêm",
                        style: TextStyleConstant.white16Roboto,
                      ),
                onPressed: () async {
                  if (Get.isRegistered<BookingStepController>()) {
                    await controller.createNewCar(false);
                  } else {
                    await controller.createNewCar(true);
                  }
                },
              ),
            ),
          ),
        ),
        body: SafeArea(
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
                    'Thông Tin Phương Tiện',
                    style: TextStyleConstant.black22RobotoBold,
                  )),
                ),
                Expanded(
                  child: SizedBox(),
                )
              ],
            )),
            Expanded(
                flex: 9,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: UtilsReponsive.width(context, 20)),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                              new TextSpan(text: 'Biển số xe '),
                              new TextSpan(
                                  text: '*',
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormFieldWidget(
                            radiusBorder: UtilsReponsive.height(context, 30),
                            padding: 10,
                            // initValue: controller.name.value,
                            textInputType: TextInputType.text,
                            labelText: "Nhập bien so xe",
                            errorText: '',
                            setValueFunc: controller.setNumCarValue),
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
                              new TextSpan(text: 'Thương hiệu xe'),
                              new TextSpan(
                                  text: '*',
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(Container(
                              color: Colors.white,
                              height: UtilsReponsive.height(context, 400),
                              width: double.infinity,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.listBrand.length,
                                  itemBuilder: (context, index) => Obx(
                                        () => ListTile(
                                            onTap: () {
                                              controller.setBrandValue(
                                                  controller.listBrand[index]);
                                              Get.back();
                                            },
                                            title: Text(
                                                controller.listBrand[index]),
                                            trailing: controller
                                                        .listBrand[index] ==
                                                    controller.brand.value
                                                ? Icon(
                                                    Icons.check,
                                                    color:
                                                        ColorsManager.primary,
                                                  )
                                                : SizedBox.shrink()),
                                      )),
                            ));
                          },
                          child: FormFieldWidget(
                              controllerEditting: controller.textEdittingBrand,
                              suffixIcon: Icon(Icons.arrow_drop_down),
                              isEnabled: false,
                              radiusBorder: UtilsReponsive.height(context, 30),
                              padding: 10,
                              textInputType: TextInputType.text,
                              setValueFunc: () {}),
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
                              new TextSpan(text: 'Mẫu xe '),
                              new TextSpan(
                                  text: '*',
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(Container(
                              color: Colors.white,
                              height: UtilsReponsive.height(context, 400),
                              width: double.infinity,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.listNumber.length,
                                  itemBuilder: (context, index) => Obx(
                                        () => ListTile(
                                            onTap: () {
                                              controller.setNumSitValue(
                                                  controller.listNumber[index]);
                                              Get.back();
                                            },
                                            title: Text(
                                                '${controller.listNumber[index]} chỗ'),
                                            trailing: controller
                                                        .listNumber[index] ==
                                                    controller.numSit.value
                                                ? Icon(
                                                    Icons.check,
                                                    color:
                                                        ColorsManager.primary,
                                                  )
                                                : SizedBox.shrink()),
                                      )),
                            ));
                          },
                          child: FormFieldWidget(
                              controllerEditting: controller.textEdittingNumsit,
                              suffixIcon: Icon(Icons.arrow_drop_down),
                              isEnabled: false,
                              radiusBorder: UtilsReponsive.height(context, 30),
                              padding: 10,
                              // initValue: controller.name.value,
                              textInputType: TextInputType.text,
                              errorText: '',
                              setValueFunc: () {}),
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
                              new TextSpan(text: 'Loại nhiên liệu'),
                              new TextSpan(
                                  text: '*',
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(Container(
                              color: Colors.white,
                              height: UtilsReponsive.height(context, 400),
                              width: double.infinity,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.fuelOptions.length,
                                  itemBuilder: (context, index) => Obx(
                                        () => ListTile(
                                            onTap: () {
                                              controller.setFuelChoiceValue(
                                                  controller
                                                      .fuelOptions[index]);
                                              Get.back();
                                            },
                                            title: Text(
                                                '${controller.fuelOptions[index]}'),
                                            trailing: controller
                                                        .fuelOptions[index] ==
                                                    controller.fuelChoice.value
                                                ? Icon(
                                                    Icons.check,
                                                    color:
                                                        ColorsManager.primary,
                                                  )
                                                : SizedBox.shrink()),
                                      )),
                            ));
                          },
                          child: FormFieldWidget(
                              controllerEditting: controller.textEdittingFuel,
                              suffixIcon: Icon(Icons.arrow_drop_down),
                              isEnabled: false,
                              radiusBorder: UtilsReponsive.height(context, 30),
                              padding: 10,
                              // initValue: controller.name.value,
                              textInputType: TextInputType.text,
                              errorText: '',
                              setValueFunc: () {}),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text('Mô tả thông tin xe'),
                        SizedBox(
                          height: 10,
                        ),
                        FormFieldWidget(
                            paddingVerti: 20,
                            maxLine: 4,
                            radiusBorder: UtilsReponsive.height(context, 30),
                            padding: 10,
                            // initValue: controller.name.value,
                            textInputType: TextInputType.text,
                            labelText: "[Ví dụ : Hãng xe - Loại xe]",
                            errorText: '',
                            setValueFunc: controller.setDescriptionValue),
                      ],
                    ),
                  ),
                ))
          ],
        )));
  }
}
