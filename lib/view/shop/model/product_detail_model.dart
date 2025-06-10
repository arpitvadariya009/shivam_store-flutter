class ProductsDetailModel {
  String? message;
  Data? data;

  ProductsDetailModel({this.message, this.data});

  factory ProductsDetailModel.fromJson(Map<String, dynamic> json) =>
      ProductsDetailModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"message": message, "data": data?.toJson()};
}

class Data {
  String? id;
  String? code;
  String? subCategoryId;
  String? image;
  int? setSize;
  List<Variant>? variants;

  Data({
    this.id,
    this.code,
    this.subCategoryId,
    this.image,
    this.setSize,
    this.variants,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    code: json["code"],
    subCategoryId: json["subCategoryId"],
    image: json["image"],
    setSize: json["setSize"],
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
    qty: json["qty"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "available": available,
    "_id": id,
    "qty": qty,
  };
}
