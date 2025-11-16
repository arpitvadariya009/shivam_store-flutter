import 'package:shivam_stores/view/shop/model/product_detail_model.dart';

class CartModel {
  bool? success;
  String? message;
  String? note;
  List<CartData>? cart;

  CartModel({this.success, this.cart, this.message, this.note});

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    success: json["success"],
    message: json["message"],
    note: json["note"],
    cart:
        json["cart"] == null
            ? []
            : json["cart"] is Map
            ? [CartData.fromJson(json["cart"])]
            : List<CartData>.from(
              json["cart"].map((x) => CartData.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "note": note,
    "success": success,
    "message": message,
    "cart": List<dynamic>.from(cart!.map((x) => x.toJson())),
  };
}

// class Cart {
//   CartData? productId;

//   Cart({this.productId});

//   factory Cart.fromJson(Map<String, dynamic> json) =>
//       Cart(productId: CartData.fromJson(json["productId"]));

//   Map<String, dynamic> toJson() => {"productId": productId?.toJson()};
// }
