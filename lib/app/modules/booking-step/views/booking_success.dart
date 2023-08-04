import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/resources/text_style.dart';
import 'package:me_car_customer/app/routes/app_pages.dart';

class BookingSuccess extends StatelessWidget {
  const BookingSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
            margin: EdgeInsets.only(bottom: UtilsReponsive.height(context, 5)),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            width: double.infinity,
            height: UtilsReponsive.height(context, 70),
            child: Column(
              mainAxisSize:MainAxisSize.max,
              children: [
                // Expanded(
                //   child: SizedBox(
                //     width:double.infinity,
                //     child: ElevatedButton(
                //         onPressed: () {
                //         },
                //         style: ElevatedButton.styleFrom(
                //           backgroundColor: ColorsManager.primary,
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(25),
                //           ),
                //           textStyle: TextStyle(),
                //         ),
                //         child:
                //             Text("Đơn hàng", style: TextStyleConstant.white16Roboto)),
                //   ),
                // ),
               SizedBox(height: 10,),
                  Expanded(
                  child: Container(
                    margin:EdgeInsets.only(bottom: 10),
                    width:double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Get.offAllNamed(Routes.HOME);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.primary,
                         shape: RoundedRectangleBorder(
                          
                            borderRadius: BorderRadius.circular(25),
                          ),
                          textStyle: TextStyle(),
                        ),
                        child:
                            Text("Về trang chủ", style: TextStyleConstant.white16RobotoBold)),
                  ),
                ),
              ],
            ),
          ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset('assets/images/booking_success.svg'),
          ),
          SizedBox(
            height: UtilsReponsive.height(context, 20),
          ),
          Text('Lịch hẹn đã được đặt thành công ',
              style: TextStyleConstant.primary22RobotoBold),
                SizedBox(
            height: UtilsReponsive.height(context, 20),
          ),
        ],
      ),
    );
  }
}
