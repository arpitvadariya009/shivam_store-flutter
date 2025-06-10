class CategoriesModel {
  bool? success;
  String? message;
  List<CategoriesData>? data;

  CategoriesModel({this.success, this.data, this.message});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        success: json["success"],
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<CategoriesData>.from(
                  json["data"].map((x) => CategoriesData.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CategoriesData {
  String? id;
  String? name;
  String? code;
  String? image;
  bool? status;
  CategoryId? categoryId;

  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  CategoriesData({
    this.id,
    this.name,
    this.image,
    this.code,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.categoryId,

    this.v,
  });

  factory CategoriesData.fromJson(Map<String, dynamic> json) => CategoriesData(
    id: json["_id"],
    name: json["name"],
    code: json["code"],
    image: json["image"],
    categoryId:
        json["categoryId"] == null
            ? null
            : CategoryId.fromJson(json["categoryId"]),

    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "image": image,
    "code": code,
    "categoryId": categoryId?.toJson(),

    "status": status,
  };
}

class CategoryId {
  String? id;
  String? name;

  CategoryId({this.id, this.name});

  factory CategoryId.fromJson(Map<String, dynamic> json) =>
      CategoryId(id: json["_id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}
