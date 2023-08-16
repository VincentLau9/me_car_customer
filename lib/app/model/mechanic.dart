// To parse this JSON data, do
//
//     final mechanic = mechanicFromJson(jsonString);

import 'dart:convert';

Mechanic mechanicFromJson(String str) => Mechanic.fromJson(json.decode(str));

String mechanicToJson(Mechanic data) => json.encode(data.toJson());

class Mechanic {
    int? mechanicId;
    bool? isMainMechanic;
    String? fullName;
    String? image;

    Mechanic({
        this.mechanicId,
        this.isMainMechanic,
        this.fullName,
        this.image,
    });

    factory Mechanic.fromJson(Map<String, dynamic> json) => Mechanic(
        mechanicId: json["mechanicId"],
        isMainMechanic: json["isMainMechanic"],
        fullName: json["fullName"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "mechanicId": mechanicId,
        "isMainMechanic": isMainMechanic,
        "fullName": fullName,
        "image": image,
    };
}
