// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    int? userId;
    int? garageId;
    String? userToken;
    String? userFirstName;
    String? userLastName;
    String? userFullName;
    String? userEmail;
    dynamic userImage;
    String? userPhone;
    String? refreshToken;
    DateTime? tokenCreated;
    DateTime? tokenExpires;
    RoleDto? roleDto;

    UserModel({
        this.userId,
        this.garageId,
        this.userToken,
        this.userFirstName,
        this.userLastName,
        this.userFullName,
        this.userEmail,
        this.userImage,
        this.userPhone,
        this.refreshToken,
        this.tokenCreated,
        this.tokenExpires,
        this.roleDto,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["userId"],
        garageId: json["garageId"],
        userToken: json["userToken"],
        userFirstName: json["userFirstName"],
        userLastName: json["userLastName"],
        userFullName: json["userFullName"],
        userEmail: json["userEmail"],
        userImage: json["userImage"],
        userPhone: json["userPhone"],
        refreshToken: json["refreshToken"],
        tokenCreated: json["tokenCreated"] == null ? null : DateTime.parse(json["tokenCreated"]),
        tokenExpires: json["tokenExpires"] == null ? null : DateTime.parse(json["tokenExpires"]),
        roleDto: json["roleDto"] == null ? null : RoleDto.fromJson(json["roleDto"]),
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "garageId": garageId,
        "userToken": userToken,
        "userFirstName": userFirstName,
        "userLastName": userLastName,
        "userFullName": userFullName,
        "userEmail": userEmail,
        "userImage": userImage,
        "userPhone": userPhone,
        "refreshToken": refreshToken,
        "tokenCreated": tokenCreated?.toIso8601String(),
        "tokenExpires": tokenExpires?.toIso8601String(),
        "roleDto": roleDto?.toJson(),
    };
}

class RoleDto {
    String? roleName;

    RoleDto({
        this.roleName,
    });

    factory RoleDto.fromJson(Map<String, dynamic> json) => RoleDto(
        roleName: json["roleName"],
    );

    Map<String, dynamic> toJson() => {
        "roleName": roleName,
    };
}
