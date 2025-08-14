// To parse this JSON data, do
//
//     final manageOrderModel = manageOrderModelFromJson(jsonString);

import 'dart:convert';

ManageOrderModel manageOrderModelFromJson(String str) =>
    ManageOrderModel.fromJson(json.decode(str));

String manageOrderModelToJson(ManageOrderModel data) =>
    json.encode(data.toJson());

class ManageOrderModel {
  bool? success;
  int? total;
  List<Order>? orders;

  ManageOrderModel({this.success, this.total, this.orders});

  factory ManageOrderModel.fromJson(Map<String, dynamic> json) =>
      ManageOrderModel(
        success: json["success"],
        total: json["total"],
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "total": total,
    "orders": List<dynamic>.from(orders!.map((x) => x.toJson())),
  };
}

class Order {
  DateTime? date;
  String? city;
  String? category;
  String? productName;
  String? status;
  String? orderId;

  Order({
    this.date,
    this.city,
    this.category,
    this.productName,
    this.status,
    this.orderId,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    date: DateTime.parse(json["date"]),
    city: json["city"],
    category: json["category"],
    productName: json["productName"],
    status: json["status"],
    orderId: json["orderId"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "city": city,
    "category": category,
    "productName": productName,
    "status": status,
    "orderId": orderId,
  };
}
