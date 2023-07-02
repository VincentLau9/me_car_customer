// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
part 'user.g.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
    String? userToken;
  @HiveField(1)
    String? userFirstName;
  @HiveField(2)
    String? userLastName;
  @HiveField(3)
    String? userFullName;
  @HiveField(4)
    String? userEmail;
  @HiveField(5)
    String? password;

    UserModel({
        this.userToken,
        this.userFirstName,
        this.userLastName,
        this.userFullName,
        this.userEmail,
        this.password
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userToken: json["userToken"],
        userFirstName: json["userFirstName"],
        userLastName: json["userLastName"],
        userFullName: json["userFullName"],
        userEmail: json["userEmail"],
    );

    Map<String, dynamic> toJson() => {
        "userToken": userToken,
        "userFirstName": userFirstName,
        "userLastName": userLastName,
        "userFullName": userFullName,
        "userEmail": userEmail,
    };
}
