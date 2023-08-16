// To parse this JSON data, do
//
//     final coupon = couponFromJson(jsonString);

import 'dart:convert';

Coupon couponFromJson(String str) => Coupon.fromJson(json.decode(str));

String couponToJson(Coupon data) => json.encode(data.toJson());

class Coupon {
    int? couponId;
    String? couponCode;
    String? couponValue;
    String? couponEndDate;
    String? couponMinSpend;
    String? couponType;

    Coupon({
        this.couponId,
        this.couponCode,
        this.couponValue,
        this.couponEndDate,
        this.couponMinSpend,
        this.couponType,
    });

    factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        couponId: json["couponId"],
        couponCode: json["couponCode"],
        couponValue: json["couponValue"],
        couponEndDate: json["couponEndDate"],
        couponMinSpend: json["couponMinSpend"],
        couponType: json["couponType"],
    );

    Map<String, dynamic> toJson() => {
        "couponId": couponId,
        "couponCode": couponCode,
        "couponValue": couponValue,
        "couponEndDate": couponEndDate,
        "couponMinSpend": couponMinSpend,
        "couponType": couponType,
    };
}
