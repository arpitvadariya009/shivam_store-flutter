// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? message;
  bool? success;
  UserData? data;

  UserModel({this.message, this.data, this.success});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    message: json["message"],
    success: json["success"],
    data: UserData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
    "success": success,
  };
}

class UserData {
  String? id;
  String? firmName;
  String? city;
  String? mobile;
  String? pin;
  bool? isverified;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserData({
    this.id,
    this.firmName,
    this.city,
    this.mobile,
    this.pin,
    this.isverified,
    this.createdAt,
    this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["_id"],
    firmName: json["firmName"],
    city: json["city"],
    mobile: json["mobile"],
    pin: json["pin"],
    isverified: json["isverified"],
    createdAt: DateTime.tryParse(json["createdAt"]),
    updatedAt: DateTime.tryParse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firmName": firmName,
    "city": city,
    "mobile": mobile,
    "pin": pin,
    "isverified": isverified,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
