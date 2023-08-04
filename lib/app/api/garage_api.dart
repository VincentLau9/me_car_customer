import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:me_car_customer/app/model/garage.dart';
import 'package:me_car_customer/app/model/search_filter.dart';
import 'package:me_car_customer/app/model/service_filter.dart';
import 'package:me_car_customer/app/model/service_garage.dart';
import 'package:me_car_customer/app/model/staff.dart';
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
            'bearer ${Get.find<StartAppController>().accessToken}'
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
            'bearer ${Get.find<StartAppController>().accessToken}'
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
            'bearer ${Get.find<StartAppController>().accessToken}'
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
  //getServiceOfGarage
  static Future<List<ServiceGarage>> getServiceOfGarage(int idGarage,int numberOfCarLot) async {
    var url = Uri.parse(BaseLink.GET_SERVICES_GARAGE+idGarage.toString()+'&'+numberOfCarLot.toString());
    log(url.toString());
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'bearer ${Get.find<StartAppController>().accessToken}'
      },
    );
    log('getServiceOfGarage: ${response.statusCode} ${response.body}');

    if (response.statusCode.toString() == '200') {
      List<ServiceGarage> listCar = [];
      final mapData = jsonDecode(response.body).cast<Map<String, dynamic>>();
        listCar = mapData.map<ServiceGarage>((json) {
          return ServiceGarage.fromJson(json);
        }).toList();
        return listCar;
    } else {
      return Future<List<ServiceGarage>>.value([]);
  }

}
 static Future<List<ServiceFilter>> getServicesFilter() async {
    var url = Uri.parse(BaseLink.GET_SERVICES_FILTER);
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'bearer ${Get.find<StartAppController>().accessToken}'
      },
    );
    log('getServicesFilter: ${response.statusCode} ${response.body}');

    if (response.statusCode.toString() == '200') {
      List<ServiceFilter> listCar = [];
      final mapData = jsonDecode(response.body).cast<Map<String, dynamic>>();
        listCar = mapData.map<ServiceFilter>((json) {
          return ServiceFilter.fromJson(json);
        }).toList();
        return listCar;
    } else {
      return Future<List<ServiceFilter>>.value([]);
  }
 }
 static Future<List<GarageModel>> searchGarageByFilter(SearchFilter searchFilter) async {
    var url = Uri.parse(BaseLink.SEARCH_GARAGE_BY_FILTER);
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'bearer ${Get.find<StartAppController>().accessToken}'
      },
      body: jsonEncode(searchFilter.toJson()),
    );
    log('searchGarageByFilter: ${response.statusCode} ${response.body}');

    if (response.statusCode.toString() == '200') {
      List<GarageModel> listCar = [];
      final mapData = jsonDecode(response.body).cast<Map<String, dynamic>>();
        listCar = mapData.map<GarageModel>((json) {
          return GarageModel.fromJson(json);
        }).toList();
        return listCar;
    } else {
      return Future<List<GarageModel>>.value([]);
  }
 }
  static Future<List<Staff>> getAllSatffByGarage(String idGarage) async {
    var url = Uri.parse(BaseLink.GET_STAFF_GARAGE+'${idGarage}');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'bearer ${Get.find<StartAppController>().accessToken}'
      },
    );
    log('getAllSatffByGarage: ${response.statusCode} ${response.body}');

    if (response.statusCode.toString() == '200') {
      // return Future<List<Staff>>.value([]);
      List<Staff> listStaff = [];
      final mapData = jsonDecode(response.body).cast<Map<String, dynamic>>();
        listStaff = mapData.map<Staff>((json) {
          return Staff.fromJson(json);
        }).toList();
        return listStaff;
    } else {
      return Future<List<Staff>>.value([]);
  }
 }

}
