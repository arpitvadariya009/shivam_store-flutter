class ProductsDetailModel {
  String? message;
  List<CartData>? data;

  ProductsDetailModel({this.message, this.data});

  factory ProductsDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductsDetailModel(
      message: json["message"],
      data:
          json["data"] == null
              ? []
              : json["data"] is Map
              ? [CartData.fromJson(json["data"])]
              : List<CartData>.from(
                json["data"].map((x) => CartData.fromJson(x)),
              ),
    );
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
  int? type;
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
  });

  factory CartData.fromJson(Map<String, dynamic> json) => CartData(
    id: json["_id"],
    code: json["code"],
    subCategoryId: json["subCategoryId"],
    image: json["image"],
    setSize: json["setSize"],
    isFavorite: json["isFavorite"],
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
    "variants": List<dynamic>.from(variants!.map((x) => x.toJson())),
  };
}

class Variant {
  String? name;
  bool? available;
  String? id;
  int? qty = 0;

  Variant({this.name, this.available, this.id, this.qty});

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    name: json["name"],
    available: json["available"],
    id: json["_id"],
    qty: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "available": available,
    "_id": id,
    "quantity": qty,
  };
}
