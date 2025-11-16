// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  bool? success;
  Map<String, List<String>>? groupedOrders;

  OrderModel({this.success, this.groupedOrders});

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    success: json["success"],
    groupedOrders:
        json["groupedOrders"] == null
            ? {}
            : Map.from(json["groupedOrders"]).map(
              (k, v) => MapEntry<String, List<String>>(
                k,
                List<String>.from(v.map((x) => x)),
              ),
            ),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "groupedOrders": Map.from(groupedOrders ?? {}).map(
      (k, v) =>
          MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x))),
    ),
  };
}
