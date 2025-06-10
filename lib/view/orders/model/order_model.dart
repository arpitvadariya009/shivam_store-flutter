class OrderModel {
  String? message;
  List<OrderData>? data;

  OrderModel({this.message, this.data});

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    message: json["message"],
    data:
        json["data"] == null
            ? []
            : List<OrderData>.from(
              json["data"].map((x) => OrderData.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class OrderData {
  DateTime? date;
  List<String>? products;

  OrderData({this.date, this.products});

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    date: DateTime.parse(json["date"]),
    products:
        json["products"] == null
            ? []
            : List<String>.from(json["products"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "date": date?.toIso8601String(),
    "products": List<dynamic>.from(products!.map((x) => x)),
  };
}
