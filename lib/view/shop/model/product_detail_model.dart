import 'dart:developer';

class ProductsDetailModel {
  String? message;
  List<CartData>? data;

  ProductsDetailModel({this.message, this.data});

  factory ProductsDetailModel.fromJson(Map<String, dynamic> json) {
    final rawData = json["data"];

    // If data is null → return empty list
    if (rawData == null) {
      return ProductsDetailModel(message: json["message"], data: []);
    }

    // If data is a map → convert to single item list
    if (rawData is Map<String, dynamic>) {
      return ProductsDetailModel(
        message: json["message"],
        data: [CartData.fromJson(rawData)],
      );
    }

    // If data is a list → remove nulls and parse
    if (rawData is List) {
      return ProductsDetailModel(
        message: json["message"],
        data:
            rawData
                .where((e) => e != null) // remove null items
                .map((e) => CartData.fromJson(e as Map<String, dynamic>))
                .toList(),
      );
    }

    // Fallback
    return ProductsDetailModel(message: json["message"], data: []);
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from((data ?? []).map((x) => x.toJson())),
  };
}

class CartData {
  String? id;
  bool? isFavorite;
  String? code;
  String? subCategoryId;
  String? image;
  int? setSize;
  String? media;
  String? mediaType;
  int? type;
  String? categoryId;
  List<Variant>? variants;

  CartData({
    this.id,
    this.code,
    this.subCategoryId,
    this.image,
    this.setSize,
    this.variants,
    this.isFavorite,
    this.type,
    this.categoryId,
    this.media,
    this.mediaType,
  });

  factory CartData.fromJson(Map<String, dynamic> json) => CartData(
    id: json["_id"],
    code: json["code"],
    subCategoryId: json["subCategoryId"],
    image: json["image"],
    setSize: json["setSize"],
    isFavorite: json["isFavorite"] ?? false,
    categoryId: json["categoryId"],
    media: json["media"],
    mediaType: json["mediaType"],
    type: json["type"],
    variants:
        json["variants"] == null
            ? []
            : List<Variant>.from(
              json["variants"].map((x) => Variant.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "code": code,
    "subCategoryId": subCategoryId,
    "image": image,
    "setSize": setSize,
    "isFavorite": isFavorite,
    "type": type,
    "categoryId": categoryId,
    "media": media,
    "mediaType": mediaType,
    "variants":
        variants == null
            ? []
            : List<dynamic>.from(variants!.map((x) => x.toJson())),
  };
}

class Variant {
  String? name;
  bool? available;
  String? id;
  int? setSize;
  int? manageOrderStatus;

  int? qty = 0;

  Variant({
    this.name,
    this.available,
    this.setSize,
    this.id,
    this.qty,
    this.manageOrderStatus,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    name: json["name"],
    available: json["available"],
    id: json["_id"],
    setSize: json["setSize"],
    manageOrderStatus: json["manageOrderStatus"],

    qty: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "available": available,
    "_id": id,
    "setSize": setSize,
    "quantity": qty,
    "manageOrderStatus": manageOrderStatus,
  };
}
