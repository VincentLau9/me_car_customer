import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/resources/text_style.dart';

import '../controllers/booking_inprogress_controller.dart';

class BookingInprogressView extends GetView<BookingInprogressController> {
  const BookingInprogressView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'Đơn Hàng Của Tôi',
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
              child: ListView.separated(
                padding: EdgeInsets.only(top: 0),
                shrinkWrap: true,
                itemCount: 10,
                separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
                itemBuilder: (context, index) {
                  return _itemBooking(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _itemBooking(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: UtilsReponsive.width(context, 15),
            vertical: UtilsReponsive.height(context, 20)),
        width: UtilsReponsive.width(context, 320),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            Positioned(top: 0, right: 0, child: Icon(Icons.more_vert)),
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                        width: UtilsReponsive.width(context, 70),
                        height: UtilsReponsive.width(context, 63),
                        child: Image.asset('assets/images/Icon.png')),
                    Padding(
                      padding: EdgeInsets.only(
                          left: UtilsReponsive.width(context, 10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: UtilsReponsive.width(context, 20)),
                            child: Text('AUDI A5 2015'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 14,
                                height: 14,
                                child: SvgPicture.asset(
                                  'assets/images/location.svg',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '23/01/2023 - 8:00 AM',
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 14,
                                height: 14,
                                child: SvgPicture.asset(
                                  'assets/images/clock.svg',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Quận 6, Hồ Chí Minh',
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '18,760,000 VNĐ',
                      style: TextStyleConstant.primary16RobotoBold,
                    )
                  ],
                )
              ],
            )
          ],
        ));
  }
}
