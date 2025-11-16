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
    data: json["data"] == null ? null : UserData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
    "success": success,
  };
}

class UserData {
  int? userType;

  String? id;
  String? firmName;
  String? city;
  String? mobile;
  String? pin;
  bool? isverified;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? latitude;
  double? longitude;

  UserData({
    this.id,
    this.firmName,
    this.city,
    this.mobile,
    this.pin,
    this.isverified,
    this.createdAt,
    this.updatedAt,
    this.userType,
    this.latitude,
    this.longitude,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["_id"],
    userType: json["userType"],

    firmName: json["firmName"],
    city: json["city"],
    mobile: json["mobile"],
    pin: json["pin"],
    isverified: json["isverified"],
    createdAt: DateTime.tryParse(json["createdAt"]),
    updatedAt: DateTime.tryParse(json["updatedAt"]),
    latitude: (json["latitude"] ?? 0).toDouble(),
    longitude: (json["longitude"] ?? 0).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userType": userType,

    "firmName": firmName,
    "city": city,
    "mobile": mobile,
    "pin": pin,
    "isverified": isverified,
    "latitude": latitude,
    "longitude": longitude,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
