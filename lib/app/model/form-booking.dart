// To parse this JSON data, do
//
//     final formBooking = formBookingFromJson(jsonString);

import 'dart:convert';

FormBooking formBookingFromJson(String str) =>
    FormBooking.fromJson(json.decode(str));

String formBookingToJson(FormBooking data) => json.encode(data.toJson());

class FormBooking {
  String customerName;
  String customerPhone;
  String customerEmail;
  String dateSelected;
  String timeSelected;
  List<int> serviceList;
  int? mechanicId;
  int carId;
  int garageId;
  int? couponId;

  FormBooking({
    required this.customerName,
    required this.customerPhone,
    required this.customerEmail,
    required this.dateSelected,
    required this.timeSelected,
    required this.serviceList,
    this.mechanicId = 0,
    required this.carId,
    required this.garageId,
    this.couponId = 0,
  });

  factory FormBooking.fromJson(Map<String, dynamic> json) => FormBooking(
        customerName: json["customerName"],
        customerPhone: json["customerPhone"],
        customerEmail: json["customerEmail"],
        dateSelected: json["dateSelected"],
        timeSelected: json["timeSelected"],
        serviceList: json["serviceList"] == null
            ? []
            : List<int>.from(json["serviceList"]!.map((x) => x)),
        mechanicId: json["mechanicId"],
        carId: json["carId"],
        garageId: json["garageId"],
        couponId: json["couponId"],
      );

  Map<String, dynamic> toJson() => {
        "customerName": customerName,
        "customerPhone": customerPhone,
        "customerEmail": customerEmail,
        "dateSelected": dateSelected,
        "timeSelected": timeSelected,
        "serviceList": serviceList == null
            ? []
            : List<dynamic>.from(serviceList!.map((x) => x)),
        "mechanicId": mechanicId,
        "carId": carId,
        "garageId": garageId,
        "couponId": couponId,
      };
}
