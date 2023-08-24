import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:me_car_customer/app/model/form-booking.dart';
import 'package:me_car_customer/app/modules/start_app/controllers/start_app_controller.dart';
import 'package:me_car_customer/app/resources/base_link.dart';
import 'package:http/http.dart' as http;

class BookingApi {
  static Future<dynamic> checkout(List<int> listIdService, int idCoupon) async {
    var url = Uri.parse(BaseLink.CHECK_OUT);
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'bearer ${Get.find<StartAppController>().accessToken}'
      },
      body: jsonEncode(<String, dynamic>{
        "serviceList": listIdService,
        "couponId": idCoupon
      }),
    );
    log('checkout: ${response.statusCode} ${response.body}');

    return response;
  }

  static Future<dynamic> createRatting(
      int star, int garageId, String content) async {
    var url = Uri.parse(BaseLink.RATTING);
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'bearer ${Get.find<StartAppController>().accessToken}'
      },
      body: jsonEncode(<String, dynamic>{
        "rating": star,
        "content": content,
        "garageId": garageId
      }),
    );
    log('createRatting: ${response.statusCode} ${response.body}');

    return response;
  }

  static Future<dynamic> createBooking(FormBooking formBooking) async {
    var url = Uri.parse(BaseLink.CREATE_BOOKING);
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'bearer ${Get.find<StartAppController>().accessToken}'
      },
      body: jsonEncode(formBooking.toJson()),
    );
    log('createBooking: ${response.statusCode} ${response.body}');

    return response;
  }

  static Future<dynamic> loadBooking(int status) async {
    var url = Uri.parse(BaseLink.LOADING_BOOKING + '${status}');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'bearer ${Get.find<StartAppController>().accessToken}'
      },
    );
    log('loadBooking: ${response.statusCode} ${response.body}');

    return response;
  }

  static Future<dynamic> loadBookingDetail(int idBooking) async {
    var url = Uri.parse(BaseLink.LOADING_BOOKING_DETAIL + '${idBooking}');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'bearer ${Get.find<StartAppController>().accessToken}'
      },
    );
    log('loadBookingDetail: ${response.statusCode} ${response.body}');

    return response;
  }

  static Future<dynamic> getBooingServiceStatus(int idBooking) async {
    var url = Uri.parse(BaseLink.GET_BOOKING_SERVICE_STATUS + '${idBooking}');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'bearer ${Get.find<StartAppController>().accessToken}'
      },
    );
    log('getBooingServiceStatus: ${response.statusCode} ${response.body}');

    return response;
  }
    static Future<dynamic> getMechanic(int idBooking) async {
    var url = Uri.parse(BaseLink.GET_MACHANIC + '${idBooking}');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'bearer ${Get.find<StartAppController>().accessToken}'
      },
    );
    log('getMechanic: ${response.statusCode} ${response.body}');

    return response;
  }

  static Future<dynamic> changeStatus(int idBooking, int status) async {
    log(idBooking.toString());
    var url = Uri.parse(BaseLink.UPDATE_STATUS + '${idBooking}&${status}');
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'bearer ${Get.find<StartAppController>().accessToken}'
      },
    );
    log('changeStatus: ${response.statusCode} ${response.body}');

    return response;
  }
}
