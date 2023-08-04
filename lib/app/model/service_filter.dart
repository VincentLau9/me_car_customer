// To parse this JSON data, do
//
//     final serviceFilter = serviceFilterFromJson(jsonString);

import 'dart:convert';

ServiceFilter serviceFilterFromJson(String str) => ServiceFilter.fromJson(json.decode(str));

String serviceFilterToJson(ServiceFilter data) => json.encode(data.toJson());

class ServiceFilter {
    int? serviceId;
    String? serviceName;
    String? serviceImage;

    ServiceFilter({
        this.serviceId,
        this.serviceName,
        this.serviceImage,
    });

    factory ServiceFilter.fromJson(Map<String, dynamic> json) => ServiceFilter(
        serviceId: json["serviceId"],
        serviceName: json["serviceName"],
        serviceImage: json["serviceImage"],
    );

    Map<String, dynamic> toJson() => {
        "serviceId": serviceId,
        "serviceName": serviceName,
        "serviceImage": serviceImage,
    };
}
