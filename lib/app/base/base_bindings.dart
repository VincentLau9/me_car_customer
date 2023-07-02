import 'package:get/get.dart';

abstract class BaseBindings extends Bindings {
  @override
  void dependencies() {
    injectService();
  }

  void injectService();
}
