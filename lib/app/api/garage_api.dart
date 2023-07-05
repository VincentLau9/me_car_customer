import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:me_car_customer/app/model/garage.dart';
import 'package:me_car_customer/app/model/time_working.dart';
import 'package:me_car_customer/app/model/user.dart';
import 'package:me_car_customer/app/modules/start_app/controllers/start_app_controller.dart';
import 'package:me_car_customer/app/resources/base_link.dart';

class GarageApi {
  static Future<List<GarageModel>> searchGarage(double lat, double lng) async {
    var url = Uri.parse(BaseLink.searchGarage);
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization':
            'bearer ${Get.find<StartAppController>().userModelT.value.userToken}'
      },
      body: jsonEncode(
        <String, dynamic>{
          "latitude": lat,
          "longitude": lng,
          "radiusInKm": 10000000000
        },
      ),
    );
    log('lat: ${lat} lng:${lng}');
    log('searchGarage: ${response.statusCode} ${response.body}');

    // Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode.toString() == '200') {
      List<GarageModel> listGarage = [];
      final mapData = jsonDecode(response.body).cast<Map<String, dynamic>>();
      listGarage = mapData.map<GarageModel>((json) {
        return GarageModel.fromJson(json);
      }).toList();
      return listGarage;
    } else {
      Get.snackbar('Thông báo', 'searchGarage error');
      throw Exception('Some thing wrong');
    }
  }

  static Future<List<GarageModel>> searchGarageByString(String value) async {
    var url = Uri.parse(BaseLink.searchGarageByString);
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization':
            'bearer ${Get.find<StartAppController>().userModelT.value.userToken}'
      },
      body: jsonEncode(
        <String, dynamic>{"searchString": value},
      ),
    );
    log('lat: ${response.statusCode} lng:${response.body}');
    log('searchGarage: ${response.statusCode} ${response.body}');

    // Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode.toString() == '200') {
      List<GarageModel> listGarage = [];
      final mapData = jsonDecode(response.body).cast<Map<String, dynamic>>();
      listGarage = mapData.map<GarageModel>((json) {
        return GarageModel.fromJson(json);
      }).toList();
      return listGarage;
    } else {
      return [];
    }
  }

  static Future<List<TimeWorking>> checkTimeWorking(String value,int idGarage) async {
    var url = Uri.parse(BaseLink.checkTimeAvailble);
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization':
            'bearer ${Get.find<StartAppController>().userModelT.value.userToken}'
      },
      body: jsonEncode(
        <String, dynamic>{"dateSelected": value, "garageId": idGarage},
      ),
    );
    log('checkTimeWorking: ${response.statusCode} ${response.body}');

    // Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode.toString() == '200') {
      List<TimeWorking> listTimeWorking = [];
      final mapData = jsonDecode(response.body).cast<Map<String, dynamic>>();
      listTimeWorking = mapData.map<TimeWorking>((json) {
        return TimeWorking.fromJson(json);
      }).toList();
      return listTimeWorking;
    } else {
      return [];
    }
  }
}
