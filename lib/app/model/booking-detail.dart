// To parse this JSON data, do
//
//     final bookingDetail = bookingDetailFromJson(jsonString);

import 'dart:convert';

BookingDetail bookingDetailFromJson(String str) =>
    BookingDetail.fromJson(json.decode(str));

String bookingDetailToJson(BookingDetail data) => json.encode(data.toJson());

class BookingDetail {
  int? garageId;
  String? carName;
  String? customerName;
  String? customerPhone;
  String? duration;
  String? bookingDay;
  String? garageAddress;
  String? bookingStatus;
  bool? waitForAccept;
  dynamic qrImage;
  String? discountPrice;
  String? totalPrice;
  String? finalPrice;
  String? carLicensePlate;
  List<GroupServiceBookingDetailDto>? groupServiceBookingDetailDtos;

  BookingDetail(
      {this.garageId,
      this.carName,
      this.customerName,
      this.customerPhone,
      this.duration,
      this.bookingDay,
      this.garageAddress,
      this.bookingStatus,
      this.waitForAccept,
      this.qrImage,
      this.discountPrice,
      this.totalPrice,
      this.finalPrice,
      this.groupServiceBookingDetailDtos,
      this.carLicensePlate});

  factory BookingDetail.fromJson(Map<String, dynamic> json) => BookingDetail(
        garageId: json["garageId"],
        carName: json["carName"],
        customerName: json["customerName"],
        customerPhone: json["customerPhone"],
        duration: json["duration"],
        bookingDay: json["bookingDay"],
        garageAddress: json["garageAddress"],
        bookingStatus: json["bookingStatus"],
        waitForAccept: json["waitForAccept"] ?? false,
        qrImage: json["qrImage"],
        discountPrice: json["discountPrice"],
        totalPrice: json["totalPrice"],
        finalPrice: json["finalPrice"],
        carLicensePlate: json["carLicensePlate"],
        groupServiceBookingDetailDtos:
            json["groupServiceBookingDetailDtos"] == null
                ? []
                : List<GroupServiceBookingDetailDto>.from(
                    json["groupServiceBookingDetailDtos"]!
                        .map((x) => GroupServiceBookingDetailDto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "carName": carName,
        "customerName": customerName,
        "customerPhone": customerPhone,
        "duration": duration,
        "bookingDay": bookingDay,
        "garageAddress": garageAddress,
        "bookingStatus": bookingStatus,
        "waitForAccept": waitForAccept,
        "qrImage": qrImage,
        "discountPrice": discountPrice,
        "totalPrice": totalPrice,
        "finalPrice": finalPrice,
        "carLicensePlate": carLicensePlate,
        "groupServiceBookingDetailDtos": groupServiceBookingDetailDtos == null
            ? []
            : List<dynamic>.from(
                groupServiceBookingDetailDtos!.map((x) => x.toJson())),
      };
}

class GroupServiceBookingDetailDto {
  String? serviceGroup;
  List<ServiceListBookingDetailDto>? serviceListBookingDetailDtos;

  GroupServiceBookingDetailDto({
    this.serviceGroup,
    this.serviceListBookingDetailDtos,
  });

  factory GroupServiceBookingDetailDto.fromJson(Map<String, dynamic> json) =>
      GroupServiceBookingDetailDto(
        serviceGroup: json["serviceGroup"],
        serviceListBookingDetailDtos:
            json["serviceListBookingDetailDtos"] == null
                ? []
                : List<ServiceListBookingDetailDto>.from(
                    json["serviceListBookingDetailDtos"]!
                        .map((x) => ServiceListBookingDetailDto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "serviceGroup": serviceGroup,
        "serviceListBookingDetailDtos": serviceListBookingDetailDtos == null
            ? []
            : List<dynamic>.from(
                serviceListBookingDetailDtos!.map((x) => x.toJson())),
      };
}

class ServiceListBookingDetailDto {
  bool? isNew;
  String? servicePrice;
  String? serviceName;
  String? productWarranty;
  String? serviceWarranty;

  ServiceListBookingDetailDto({
    this.isNew,
    this.servicePrice,
    this.serviceName,
    this.productWarranty,
    this.serviceWarranty
  });

  factory ServiceListBookingDetailDto.fromJson(Map<String, dynamic> json) =>
      ServiceListBookingDetailDto(
        isNew: json["isNew"] ?? false,
        servicePrice: json["servicePrice"],
        serviceName: json["serviceName"],
        productWarranty:json["productWarranty"].toString().isEmpty?"Không":json["productWarranty"],
        serviceWarranty:json["serviceWarranty"].toString().isEmpty?"Không":json["serviceWarranty"]
      );

  Map<String, dynamic> toJson() => {
        "isNew": isNew,
        "servicePrice": servicePrice,
        "serviceName": serviceName,
        "productWarranty":productWarranty,
        "serviceWarranty":serviceWarranty
      };
}
