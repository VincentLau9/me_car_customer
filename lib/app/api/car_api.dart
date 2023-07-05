import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:me_car_customer/app/model/car.dart';
import 'package:me_car_customer/app/modules/start_app/controllers/start_app_controller.dart';
import 'package:me_car_customer/app/resources/base_link.dart';
import 'package:http/http.dart' as http;

class CarApi {
  static Future<bool> createCar(Car carModel) async {
    var url = Uri.parse(BaseLink.create_car);
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'bearer ${Get.find<StartAppController>().userModelT.value.userToken}'
      },
      body: jsonEncode(<String, dynamic>{
        "carBrand": carModel.carBrand,
        "carLicensePlate": carModel.carLicensePlate,
        "carFuelType": carModel.carFuelType,
        "carDescription": carModel.carDescription,
        "numberOfCarLot": carModel.numberOfCarLot
      }),
    );
    log('loginÏ: ${response.statusCode} ${response.body}');

    if (response.statusCode.toString() == '200') {
      log(response.body);
      return Future<bool>.value(true);
    } else {
      return Future<bool>.value(false);
  }
}
static Future<List<Car>> loadAllCar() async {
    var url = Uri.parse(BaseLink.load_car);
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'bearer ${Get.find<StartAppController>().userModelT.value.userToken}'
      },
    );
    log('loadAllCar: ${response.statusCode} ${response.body}');

    if (response.statusCode.toString() == '200') {
      List<Car> listCar = [];
      final mapData = jsonDecode(response.body).cast<Map<String, dynamic>>();
        listCar = mapData.map<Car>((json) {
          return Car.fromJson(json);
        }).toList();
        return listCar;
    } else {
      return Future<List<Car>>.value([]);
  }
}
}
