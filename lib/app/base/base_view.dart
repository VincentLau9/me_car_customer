import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_controller.dart';

abstract class BaseView<T extends BaseController> extends GetView<T> {
  const BaseView({super.key});

  // final Color statusBarColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return buildView(context);
  }

  @protected
  Widget buildView(BuildContext context);
}
