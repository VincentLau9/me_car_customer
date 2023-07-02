import 'package:flutter/material.dart';

import 'package:me_car_customer/app/base/base_view.dart';
import 'package:me_car_customer/app/modules/start_app/views/splash.dart';

import '../controllers/start_app_controller.dart';

class StartAppView extends BaseView<StartAppController> {
  const StartAppView({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    return SplashStart();
  }
}
