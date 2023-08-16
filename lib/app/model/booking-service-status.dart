// To parse this JSON data, do
//
//     final bookingServiceStatus = bookingServiceStatusFromJson(jsonString);

import 'dart:convert';

BookingServiceStatus bookingServiceStatusFromJson(String str) => BookingServiceStatus.fromJson(json.decode(str));

String bookingServiceStatusToJson(BookingServiceStatus data) => json.encode(data.toJson());

class BookingServiceStatus {
    String? serviceName;
    String? bookingServiceStatus;
    String? updatedAt;

    BookingServiceStatus({
        this.serviceName,
        this.bookingServiceStatus,
        this.updatedAt,
    });

    factory BookingServiceStatus.fromJson(Map<String, dynamic> json) => BookingServiceStatus(
        serviceName: json["serviceName"],
        bookingServiceStatus: json["bookingServiceStatus"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toJson() => {
        "serviceName": serviceName,
        "bookingServiceStatus": bookingServiceStatus,
        "updatedAt": updatedAt,
    };
}
