// To parse this JSON data, do
//
//     final timeWorking = timeWorkingFromJson(jsonString);

import 'dart:convert';

TimeWorking timeWorkingFromJson(String str) => TimeWorking.fromJson(json.decode(str));

String timeWorkingToJson(TimeWorking data) => json.encode(data.toJson());

class TimeWorking {
    String? hour;
    bool? isAvailable;
    int? estimatedTimeCanBeBook;

    TimeWorking({
        this.hour,
        this.isAvailable,
        this.estimatedTimeCanBeBook,
    });

    factory TimeWorking.fromJson(Map<String, dynamic> json) => TimeWorking(
        hour: json["hour"],
        isAvailable: json["isAvailable"],
        estimatedTimeCanBeBook: json["estimatedTimeCanBeBook"],
    );

    Map<String, dynamic> toJson() => {
        "hour": hour,
        "isAvailable": isAvailable,
        "estimatedTimeCanBeBook": estimatedTimeCanBeBook,
    };
}
