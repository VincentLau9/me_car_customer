import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:me_car_customer/app/model/user.dart';
import 'package:me_car_customer/app/modules/start_app/controllers/start_app_controller.dart';
import 'package:me_car_customer/app/resources/base_link.dart';

class UserApi {
  static Future<UserModel> login(String phone, String passowrd) async {
    var url = Uri.parse(BaseLink.login);
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{"phone": phone, "password": passowrd},
      ),
    );
    log('loginÏ: ${response.statusCode} ${response.body}');
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode.toString() == '200') {
      log(response.body);
      return Future<UserModel>.value(UserModel.fromJson(data));
    } else {
      Get.snackbar('Thông báo', data['title']);
      throw Exception('Some thing wrong');
    }
  }

  static Future<bool> register(String email, String passowrd) async {
    var url = Uri.parse(BaseLink.register);
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          "userPhone": email,
          "userPassword": passowrd,
          "passwordConfirm": passowrd
        },
      ),
    );
    log('register: ${response.statusCode} ${response.body}');
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode.toString() == '200') {
      log(response.body);
      return Future<bool>.value(true);
    } else {
      Get.snackbar('Thông báo', data['title']);
      return Future<bool>.value(false);
    }
  }

  static Future<bool> sendOTP(String email) async {
    var url = Uri.parse(BaseLink.getOTP(email));
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
      },
    );
    log('sendOTP: ${response.statusCode} ${response.body}');
    if (response.statusCode.toString() == '200') {
      Map<String, dynamic> data = jsonDecode(response.body);
      return Future<bool>.value(true);
    } else {
      return Future<bool>.value(false);
    }
  }

  static Future<bool> checkOTP(String email, String otp) async {
    var url = Uri.parse(BaseLink.verifyOTP(email, otp));
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
      },
    );
    log('checkOTP: ${response.statusCode} ${response.body}');
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode.toString() == '200') {
      log(response.body);
      return Future<bool>.value(true);
    } else {
      Get.snackbar('Thông báo', data['title']);
      throw Exception(data['title']);
    }
  }

  //updateInfomation
  static Future<bool> updateInfomation(String fullName, String phone) async {
    var url = Uri.parse(BaseLink.updateInfo);
    final response = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization':
              'bearer ${Get.find<StartAppController>().accessToken}'
        },
        body: jsonEncode(<String, dynamic>{
          "userFirstName": fullName.split(' ').first,
          "userLastName": fullName.substring(fullName.split(' ').first.length),
          "userPhone": phone
        }));
    log('updateInfomation: ${response.statusCode} ${response.body}');
    log(jsonEncode(<String, dynamic>{
      "userFirstName": fullName.split(' ').first,
      "userLastName": fullName.substring(fullName.split(' ').first.length),
      "userPhone": phone
    }));
    if (response.statusCode.toString() == '200') {
      log(response.body);
      return Future<bool>.value(true);
    } else {
      return Future<bool>.value(false);
    }
  }
  static Future<bool> updateInfomationV2(String fullName, String phone,String email) async {
    var url = Uri.parse(BaseLink.updateInfo);
    final response = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization':
              'bearer ${Get.find<StartAppController>().accessToken}'
        },
        body: jsonEncode(<String, dynamic>{
          "userFirstName": fullName.split(' ').first,
          "userLastName": fullName.substring(fullName.split(' ').first.length),
        "userEmail": email
        }));
    log('updateInfomation: ${response.statusCode} ${response.body}');
    log(jsonEncode(<String, dynamic>{
      "userFirstName": fullName.split(' ').first,
      "userLastName": fullName.substring(fullName.split(' ').first.length),
      "userEmail": email
    }));
    if (response.statusCode.toString() == '200') {
      log(response.body);
      return Future<bool>.value(true);
    } else {
      return Future<bool>.value(false);
    }
  }

  static Future<dynamic> refeshToken(String refeshToken) async {
    log(refeshToken);
    var response = await http.get(
      Uri.parse(BaseLink.REFESH_TOKEN),
      headers: {
        "Accept": "text/plain",
        'Authorization': 'bearer ' + refeshToken
      },
    );
    log('refeshToken - status: ${response.statusCode}');
    log('refeshToken - body: ${response.body}');
    return response;
  }
}
