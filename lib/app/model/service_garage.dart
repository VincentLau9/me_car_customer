// To parse this JSON data, do
//
//     final serviceGarage = serviceGarageFromJson(jsonString);

import 'dart:convert';

List<ServiceGarage> serviceGarageFromJson(String str) => List<ServiceGarage>.from(json.decode(str).map((x) => ServiceGarage.fromJson(x)));

String serviceGarageToJson(List<ServiceGarage> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiceGarage {
    String? serviceGroup;
    List<ServicListDto>? servicListDtos;

    ServiceGarage({
        this.serviceGroup,
        this.servicListDtos,
    });

    factory ServiceGarage.fromJson(Map<String, dynamic> json) => ServiceGarage(
        serviceGroup: json["serviceGroup"],
        servicListDtos: json["servicListDtos"] == null ? [] : List<ServicListDto>.from(json["servicListDtos"]!.map((x) => ServicListDto.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "serviceGroup": serviceGroup,
        "servicListDtos": servicListDtos == null ? [] : List<dynamic>.from(servicListDtos!.map((x) => x.toJson())),
    };
}

class ServicListDto {
    int? serviceDetailId;
    String? servicePrice;
    String? serviceName;
    int? serviceDuration;

    ServicListDto({
        this.serviceDetailId,
        this.servicePrice,
        this.serviceName,
        this.serviceDuration,
    });

    factory ServicListDto.fromJson(Map<String, dynamic> json) => ServicListDto(
        serviceDetailId: json["serviceDetailId"],
        servicePrice: json["servicePrice"],
        serviceName: json["serviceName"],
        serviceDuration: json["serviceDuration"],
    );

    Map<String, dynamic> toJson() => {
        "serviceDetailId": serviceDetailId,
        "servicePrice": servicePrice,
        "serviceName": serviceName,
        "serviceDuration": serviceDuration,
    };
}
