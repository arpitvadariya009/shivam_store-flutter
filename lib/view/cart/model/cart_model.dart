import 'package:shivam_stores/view/shop/model/product_detail_model.dart';

class CartModel {
  bool? success;
  String? message;
  String? note;
  List<CartData>? cart;

  CartModel({this.success, this.cart, this.message, this.note});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final raw = json["cart"];

    List<CartData> parsedList = [];

    if (raw is Map<String, dynamic>) {
      parsedList = [CartData.fromJson(raw)];
    } else if (raw is List) {
      parsedList =
          raw
              .where((e) => e != null) // 🟢 FIX: skip null items
              .map((e) => CartData.fromJson(e as Map<String, dynamic>))
              .toList();
    }

    return CartModel(
      success: json["success"],
      message: json["message"],
      note: json["note"],
      cart: parsedList,
    );
  }

  Map<String, dynamic> toJson() => {
    "note": note,
    "success": success,
    "message": message,
    "cart": cart?.map((x) => x.toJson()).toList() ?? [],
  };
}
