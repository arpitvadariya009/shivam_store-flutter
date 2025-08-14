import 'package:shivam_stores/view/shop/model/product_detail_model.dart';

class CartModel {
  bool? success;
  String? message;
  List<Cart>? cart;

  CartModel({this.success, this.cart, this.message});

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    success: json["success"],
    message: json["message"],
    cart:
        json["cart"] == null
            ? []
            : List<Cart>.from(json["cart"].map((x) => Cart.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "cart": List<dynamic>.from(cart!.map((x) => x.toJson())),
  };
}

class Cart {
  CartData? productId;

  Cart({this.productId});

  factory Cart.fromJson(Map<String, dynamic> json) =>
      Cart(productId: CartData.fromJson(json["productId"]));

  Map<String, dynamic> toJson() => {"productId": productId?.toJson()};
}
