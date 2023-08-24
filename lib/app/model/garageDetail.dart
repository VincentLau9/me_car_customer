// To parse this JSON data, do
//
//     final garageDetail = garageDetailFromJson(jsonString);

import 'dart:convert';

GarageDetail garageDetailFromJson(String str) => GarageDetail.fromJson(json.decode(str));

String garageDetailToJson(GarageDetail data) => json.encode(data.toJson());

class GarageDetail {
    int? garageId;
    String? garageName;
    String? garageImage;
    String? garageContactInformation;
    String? garageAbout;
    String? garageFullAddress;
    String? garageAddress;
    String? garageWard;
    String? garageDistrict;
    String? garageCity;
    String? hoursOfOperation;
    String? isOpen;
    int? rating;
    int? avaliableCoupon;
    String? versionNumber;
    double? km;
    ManagerGarageDto? managerGarageDto;

    GarageDetail({
        this.garageId,
        this.garageName,
        this.garageImage,
        this.garageContactInformation,
        this.garageAbout,
        this.garageFullAddress,
        this.garageAddress,
        this.garageWard,
        this.garageDistrict,
        this.garageCity,
        this.hoursOfOperation,
        this.isOpen,
        this.rating,
        this.avaliableCoupon,
        this.versionNumber,
        this.managerGarageDto,
        this.km=0
    });

    factory GarageDetail.fromJson(Map<String, dynamic> json) => GarageDetail(
        garageId: json["garageId"],
        garageName: json["garageName"],
        garageImage: json["garageImage"],
        garageContactInformation: json["garageContactInformation"],
        garageAbout: json["garageAbout"],
        garageFullAddress: json["garageFullAddress"],
        garageAddress: json["garageAddress"],
        garageWard: json["garageWard"],
        garageDistrict: json["garageDistrict"],
        garageCity: json["garageCity"],
        hoursOfOperation: json["hoursOfOperation"],
        isOpen: json["isOpen"],
        rating: json["rating"],
        avaliableCoupon: json["avaliableCoupon"],
        versionNumber: json["versionNumber"],
        managerGarageDto: json["managerGarageDto"] == null ? null : ManagerGarageDto.fromJson(json["managerGarageDto"]),
    );

    Map<String, dynamic> toJson() => {
        "garageId": garageId,
        "garageName": garageName,
        "garageImage": garageImage,
        "garageContactInformation": garageContactInformation,
        "garageAbout": garageAbout,
        "garageFullAddress": garageFullAddress,
        "garageAddress": garageAddress,
        "garageWard": garageWard,
        "garageDistrict": garageDistrict,
        "garageCity": garageCity,
        "hoursOfOperation": hoursOfOperation,
        "isOpen": isOpen,
        "rating": rating,
        "avaliableCoupon": avaliableCoupon,
        "versionNumber": versionNumber,
        "managerGarageDto": managerGarageDto?.toJson(),
    };
}

class ManagerGarageDto {
    int? userId;
    String? fullName;
    String? userEmail;
    String? userPhone;
    String? userStatus;

    ManagerGarageDto({
        this.userId,
        this.fullName,
        this.userEmail,
        this.userPhone,
        this.userStatus,
    });

    factory ManagerGarageDto.fromJson(Map<String, dynamic> json) => ManagerGarageDto(
        userId: json["userId"],
        fullName: json["fullName"],
        userEmail: json["userEmail"],
        userPhone: json["userPhone"],
        userStatus: json["userStatus"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "fullName": fullName,
        "userEmail": userEmail,
        "userPhone": userPhone,
        "userStatus": userStatus,
    };
}
