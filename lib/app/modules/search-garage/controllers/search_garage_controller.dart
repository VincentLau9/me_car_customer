import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:me_car_customer/app/api/garage_api.dart';
import 'package:me_car_customer/app/base/base_controller.dart';
import 'package:me_car_customer/app/model/garage.dart';
import 'package:me_car_customer/app/routes/app_pages.dart';

class SearchGarageController extends BaseController {
  //TODO: Implement SearchGarageController
  SearchGarageController({this.isSearchFromHome = false});
  bool isSearchFromHome;
  final count = 0.obs;
  RxList<GarageModel> listGarage = <GarageModel>[].obs;
  RxBool isLoading = false.obs;
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;

  @override
  void onInit() async {
    if (isSearchFromHome) {
      isLoading(true);
    }
    Position curentPosition = await Geolocator.getCurrentPosition();
    lat(curentPosition.latitude);
    long(curentPosition.longitude);
    await searchGarage(' ');
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
  searchGarage(String value) async {
    if (value.trim().isEmpty && !isSearchFromHome) {
      listGarage.value = [];
    } else {
      isLoading(true);
      listGarage.value = await GarageApi.searchGarageByString(value);
      isLoading(false);
    }
  }

  chooseGarage(GarageModel garage) {
    Get.offNamed(Routes.BOOKING_STEP, arguments: garage);
  }
}
