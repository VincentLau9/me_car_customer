import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_view.dart';
import 'package:me_car_customer/app/modules/booking-step/controllers/booking_step_controller.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/resources/text_style.dart';

import '../controllers/coupon_view_controller.dart';

class CouponViewView extends BaseView<CouponViewController> {
  const CouponViewView({Key? key}) : super(key: key);
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
              'Mã giảm giá',
              style: TextStyleConstant.black22RobotoBold,
            )),
          ),
          Expanded(child: SizedBox())
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
              : controller.listCoupon.value.isNotEmpty
                  ? ListView.separated(
                      itemCount: controller.listCoupon.value.length,
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: UtilsReponsive.height(context, 100),
                          child: Card(
                              child: Row(
                            children: [
                              Container(
                                height: double.infinity,
                                width: UtilsReponsive.width(context, 5),
                                color: ColorsManager.primary,
                              ),
                              Expanded(
                                  child: ListTile(
                                    onTap: () async{
                               await       controller.chooseCoupon(  controller.listCoupon[index]);
                                    },
                                    trailing:
                                    Get.find<BookingStepController>().coupon.value.couponId==controller.listCoupon[index].couponId?Icon(Icons.radio_button_checked,color: ColorsManager.primary,):
                                     Icon(Icons.radio_button_off,color: ColorsManager.primary,),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.listCoupon[index].couponValue!,
                                      style:
                                          TextStyleConstant.primary16RobotoBold,
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                     'Mã KM: ' +controller.listCoupon[index].couponCode!,
                                      style: TextStyleConstant.black14Roboto,
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text( 'Ngày hết hạn: '+
                                      controller
                                          .listCoupon[index].couponEndDate!,
                                      style: TextStyleConstant.black14Roboto,
                                    )
                                  ],
                                ),
                              ))
                            ],
                          )),
                        );
                      },
                    )
                  : SizedBox()))
    ])));
  }
}
