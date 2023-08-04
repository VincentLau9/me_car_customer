// To parse this JSON data, do
//
//     final searchFilter = searchFilterFromJson(jsonString);

import 'dart:convert';

SearchFilter searchFilterFromJson(String str) => SearchFilter.fromJson(json.decode(str));

String searchFilterToJson(SearchFilter data) => json.encode(data.toJson());

class SearchFilter {
   List<int>? serviceList;
    String? dateSelected;
    double? latitude;
    double? longitude;
    double? radiusInKm;

    SearchFilter({
        this.serviceList,
        this.dateSelected,
        this.latitude,
        this.longitude,
        this.radiusInKm,
    });

    factory SearchFilter.fromJson(Map<String, dynamic> json) => SearchFilter(
        serviceList: json["serviceList"] == null ? [] : List<int>.from(json["serviceList"]!.map((x) => x)),
        dateSelected: json["dateSelected"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        radiusInKm: json["radiusInKm"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "serviceList": serviceList == null ? [] : List<dynamic>.from(serviceList!.map((x) => x)),
        "dateSelected": dateSelected,
        "latitude": latitude,
        "longitude": longitude,
        "radiusInKm": radiusInKm,
    };
}
