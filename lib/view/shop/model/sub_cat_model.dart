import 'package:shivam_stores/view/home/model/categories_model.dart';

class SubCategoriesModel {
  bool? success;
  List<CategoriesData>? subCategories;

  SubCategoriesModel({this.success, this.subCategories});

  factory SubCategoriesModel.fromJson(Map<String, dynamic> json) =>
      SubCategoriesModel(
        success: json["success"],
        subCategories:
            json["subCategories"] == null
                ? []
                : List<CategoriesData>.from(
                  json["subCategories"].map((x) => CategoriesData.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "subCategories": List<dynamic>.from(subCategories!.map((x) => x.toJson())),
  };
}
