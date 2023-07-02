// To parse this JSON data, do
//
//     final garageModel = garageModelFromJson(jsonString);

import 'dart:convert';

List<GarageModel> garageModelFromJson(String str) => List<GarageModel>.from(json.decode(str).map((x) => GarageModel.fromJson(x)));

String garageModelToJson(List<GarageModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GarageModel {
    int? garageId;
    String? garageName;
    String? garageImage;
    String? garageFullAddress;
    String? garageAddress;
    String? garageWard;
    String? garageDistrict;
    String? garageCity;
    double? garageLatitude;
    double? garageLongitude;
    String? garageStatus;
    int? rating;

    GarageModel({
        this.garageId,
        this.garageName,
        this.garageImage,
        this.garageFullAddress,
        this.garageAddress,
        this.garageWard,
        this.garageDistrict,
        this.garageCity,
        this.garageLatitude,
        this.garageLongitude,
        this.garageStatus,
        this.rating,
    });

    factory GarageModel.fromJson(Map<String, dynamic> json) => GarageModel(
        garageId: json["garageId"],
        garageName: json["garageName"],
        garageImage: json["garageImage"],
        garageFullAddress: json["garageFullAddress"],
        garageAddress: json["garageAddress"],
        garageWard: json["garageWard"],
        garageDistrict: json["garageDistrict"],
        garageCity: json["garageCity"],
        garageLatitude: json["garageLatitude"]?.toDouble(),
        garageLongitude: json["garageLongitude"]?.toDouble(),
        garageStatus: json["garageStatus"],
        rating: json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "garageId": garageId,
        "garageName": garageName,
        "garageImage": garageImage,
        "garageFullAddress": garageFullAddress,
        "garageAddress": garageAddress,
        "garageWard": garageWard,
        "garageDistrict": garageDistrict,
        "garageCity": garageCity,
        "garageLatitude": garageLatitude,
        "garageLongitude": garageLongitude,
        "garageStatus": garageStatus,
        "rating": rating,
    };
}
