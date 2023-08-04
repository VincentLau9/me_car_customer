// To parse this JSON data, do
//
//     final staff = staffFromJson(jsonString);

import 'dart:convert';

Staff staffFromJson(String str) => Staff.fromJson(json.decode(str));

String staffToJson(Staff data) => json.encode(data.toJson());

class Staff {
    int? mechanicId;
    String? level;
    String? fullName;
    String? image;

    Staff({
        this.mechanicId,
        this.level,
        this.fullName,
        this.image,
    });

    factory Staff.fromJson(Map<String, dynamic> json) => Staff(
        mechanicId: json["mechanicId"],
        level: json["level"],
        fullName: json["fullName"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "mechanicId": mechanicId,
        "level": level,
        "fullName": fullName,
        "image": image,
    };
}
