import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:me_car_customer/app/base/base_view.dart';
import 'package:me_car_customer/app/resources/assets_manager.dart';
import 'package:me_car_customer/app/resources/reponsive_utils.dart';
import 'package:me_car_customer/app/resources/text_style.dart';

import '../../controllers/tab-service-controller/tab_service_controller.dart';

class TabServiceView extends BaseView<TabServiceController> {
  const TabServiceView({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    return SafeArea(
        child: Container(
          padding:EdgeInsets.symmetric(horizontal: UtilsReponsive.width(context, 15)),
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
                    'Dịch vụ',
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
                scrollDirection: Axis.vertical,
                itemCount: 20,
                separatorBuilder: (context, index) => Container(
                  height: 1,
                  color: Colors.grey,
                  margin: EdgeInsets.only(bottom: 8),
                ),
                itemBuilder: (context, index) => Container(
                  height: UtilsReponsive.height(context, 80),
                  child: Row(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Container(
                        height: UtilsReponsive.height(context, 67),
                         width: UtilsReponsive.height(context, 62),
                         decoration:BoxDecoration(
                          color:Colors.white,
                          borderRadius:BorderRadius.circular(8),
                          border: Border.all(color:Colors.black)
                         ),
                         child: Image.asset(ImageAssets.card_jack),
                      )),
                       Expanded(
                        flex:4,
                        child: ListTile(
                          title:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Dịch vụ số ${index}',style:TextStyleConstant.black16RobotoBold,),
                              Text('Xin chào, mấy giờ bạn có thể có mặt,Xin chào, mấy giờ bạn có thể có mặt..',style: TextStyle(color: Colors.grey,fontSize: 12),)
                            ],
                          ),
                        ))
                    ],
                  ),
                ),
              ))
        ],
      ),
    ));
  }
}
