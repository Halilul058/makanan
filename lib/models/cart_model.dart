class CartModel {
  int? id;
  int userId;
  int foodId;
  int qty;

  CartModel({
    this.id,
    required this.userId,
    required this.foodId,
    required this.qty,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'food_id': foodId,
      'qty': qty,
    };
  }

  factory CartModel.fromMap(
      Map<String, dynamic> map) {
    return CartModel(
      id: map['id'],
      userId: map['user_id'],
      foodId: map['food_id'],
      qty: map['qty'],
    );
  }
}