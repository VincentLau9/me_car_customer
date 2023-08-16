// To parse this JSON data, do
//
//     final car = carFromJson(jsonString);

import 'dart:convert';

Car carFromJson(String str) => Car.fromJson(json.decode(str));

String carToJson(Car data) => json.encode(data.toJson());

class Car {
    int? carId;
    String? carModel;
    String? carBrand;
    String? carLicensePlate;
    String? carFuelType;
    int? numberOfCarLot;
    String? carDescription;
    String? carStatus;

    Car({
        this.carId,
        this.carModel,
        this.carBrand,
        this.carLicensePlate,
        this.carFuelType,
        this.numberOfCarLot,
        this.carDescription,
        this.carStatus,
    });

    factory Car.fromJson(Map<String, dynamic> json) => Car(
        carId: json["carId"],
        carModel: json["carModel"]??"",
        carBrand: json["carBrand"],
        carLicensePlate: json["carLicensePlate"],
        carFuelType: json["carFuelType"],
        numberOfCarLot: json["numberOfCarLot"],
        carDescription:json["carDescription"]??"",
        carStatus: json["carStatus"],
    );

    Map<String, dynamic> toJson() => {
        "carId": carId,
        "carModel": carModel,
        "carBrand": carBrand,
        "carLicensePlate": carLicensePlate,
        "carFuelType": carFuelType,
        "numberOfCarLot": numberOfCarLot,
        "carStatus": carStatus,
        "carDescription":carDescription
    };
}
