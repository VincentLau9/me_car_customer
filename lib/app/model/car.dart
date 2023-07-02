// To parse this JSON data, do
//
//     final car = carFromJson(jsonString);

import 'dart:convert';

Car carFromJson(String str) => Car.fromJson(json.decode(str));

String carToJson(Car data) => json.encode(data.toJson());

class Car {
    String? carModel;
    String? carBrand;
    String? carLicensePlate;
    String? carFuelType;
    String? carDescription;
    int? numberOfCarLot;

    Car({
        this.carModel,
        this.carBrand,
        this.carLicensePlate,
        this.carFuelType,
        this.carDescription,
        this.numberOfCarLot,
    });

    factory Car.fromJson(Map<String, dynamic> json) => Car(
        carModel: json["carModel"],
        carBrand: json["carBrand"],
        carLicensePlate: json["carLicensePlate"],
        carFuelType: json["carFuelType"],
        carDescription: json["carDescription"],
        numberOfCarLot: json["numberOfCarLot"],
    );

    Map<String, dynamic> toJson() => {
        "carModel": carModel,
        "carBrand": carBrand,
        "carLicensePlate": carLicensePlate,
        "carFuelType": carFuelType,
        "carDescription": carDescription,
        "numberOfCarLot": numberOfCarLot,
    };
}
