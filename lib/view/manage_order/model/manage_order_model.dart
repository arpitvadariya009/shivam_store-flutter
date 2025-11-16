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
        orders:
            json["orders"] == null
                ? []
                : List<Order>.from(
                  json["orders"].map((x) => Order.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "total": total,
    "orders": List<dynamic>.from(orders!.map((x) => x.toJson())),
  };
}

class Order {
  String? orderId;
  DateTime? date;
  String? city;
  String? firmName;
  String? category;
  String? productName;
  String? productCode;
  String? variantName;
  int? quantity;
  String? status;
  String? colorCode;
  String? note;

  Order({
    this.orderId,
    this.date,
    this.city,
    this.firmName,
    this.category,
    this.productName,
    this.productCode,
    this.variantName,
    this.quantity,
    this.status,
    this.colorCode,
    this.note,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    orderId: json["orderId"],
    date: DateTime.tryParse(json["date"]),
    city: json["city"],
    firmName: json["firmName"],
    category: json["category"],
    productName: json["productName"],
    productCode: json["productCode"],
    variantName: json["variantName"],
    quantity: json["quantity"],
    status: json["status"],
    colorCode: json["colorCode"],
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "date": date?.toIso8601String(),
    "city": city,
    "firmName": firmName,
    "category": category,
    "productName": productName,
    "productCode": productCode,
    "variantName": variantName,
    "quantity": quantity,
    "status": status,
    "note": note,
    "colorCode": colorCode,
  };
}
