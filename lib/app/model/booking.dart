// To parse this JSON data, do
//
//     final booking = bookingFromJson(jsonString);

import 'dart:convert';

Booking bookingFromJson(String str) => Booking.fromJson(json.decode(str));

String bookingToJson(Booking data) => json.encode(data.toJson());

class Booking {
  int? bookingId;
  bool? waitForAccept;
  String? bookingTime;
  String? carName;
  String? garageAddress;
  String? price;

  Booking({
    this.bookingId,
    this.waitForAccept,
    this.bookingTime,
    this.carName,
    this.garageAddress,
    this.price,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        bookingId: json["bookingId"],
        waitForAccept: json["waitForAccept"] ?? false,
        bookingTime: json["bookingTime"],
        carName: json["carName"],
        garageAddress: json["garageAddress"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "bookingId": bookingId,
        "waitForAccept": waitForAccept,
        "bookingTime": bookingTime,
        "carName": carName,
        "garageAddress": garageAddress,
        "price": price,
      };
}
