// To parse this JSON data, do
//
//     final dataSearchModel = dataSearchModelFromJson(jsonString);

import 'dart:convert';

List<DataSearchModel> dataSearchModelFromJson(String str) => List<DataSearchModel>.from(json.decode(str).map((x) => DataSearchModel.fromJson(x)));

String dataSearchModelToJson(List<DataSearchModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataSearchModel {
    DataSearchModel({
         this.description="",
         this.placeId,
         this.reference,
         this.structuredFormatting,
         this.compound,
         this.types,
        this.lat=0,
        this.lng=0
    });

    String? description;
    String? placeId;
    String? reference;
    StructuredFormatting? structuredFormatting;
    Compound? compound;
    List<String>? types;
    double? lat;
    double? lng;

    factory DataSearchModel.fromJson(Map<String, dynamic> json) => DataSearchModel(
        description: json["description"],
        placeId: json["place_id"],
        reference: json["reference"],
        structuredFormatting: StructuredFormatting.fromJson(json["structured_formatting"]),
        compound: Compound.fromJson(json["compound"]),
        types: List<String>.from(json["types"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "place_id": placeId,
        "reference": reference,
        "structured_formatting": structuredFormatting?.toJson(),
        "compound": compound?.toJson(),
        "types":types==null?[]: List<dynamic>.from(types!.map((x) => x)),
    };
}

class Compound {
    Compound({
        required this.district,
        required this.commune,
        required this.province,
    });

    String district;
    String commune;
    String province;

    factory Compound.fromJson(Map<String, dynamic> json) => Compound(
        district: json["district"],
        commune: json["commune"],
        province: json["province"],
    );

    Map<String, dynamic> toJson() => {
        "district": district,
        "commune": commune,
        "province": province,
    };
}

class StructuredFormatting {
    StructuredFormatting({
        required this.mainText,
        required this.secondaryText,
    });

    String mainText;
    String secondaryText;

    factory StructuredFormatting.fromJson(Map<String, dynamic> json) => StructuredFormatting(
        mainText: json["main_text"],
        secondaryText: json["secondary_text"],
    );

    Map<String, dynamic> toJson() => {
        "main_text": mainText,
        "secondary_text": secondaryText,
    };
}
