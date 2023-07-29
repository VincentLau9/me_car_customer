// To parse this JSON data, do
//
//     final garageModel = garageModelFromJson(jsonString);

import 'dart:convert';

GarageModel garageModelFromJson(String str) => GarageModel.fromJson(json.decode(str));

String garageModelToJson(GarageModel data) => json.encode(data.toJson());

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
    double? rating;

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
        rating: json["rating"]?.toDouble(),
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
