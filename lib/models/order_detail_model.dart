class OrderDetailModel {
  int? id;
  int orderId;
  int foodId;
  int qty;
  int price;
  int subtotal;

  OrderDetailModel({
    this.id,
    required this.orderId,
    required this.foodId,
    required this.qty,
    required this.price,
    required this.subtotal,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_id': orderId,
      'food_id': foodId,
      'qty': qty,
      'price': price,
      'subtotal': subtotal,
    };
  }

  factory OrderDetailModel.fromMap(
      Map<String, dynamic> map) {
    return OrderDetailModel(
      id: map['id'],
      orderId: map['order_id'],
      foodId: map['food_id'],
      qty: map['qty'],
      price: map['price'],
      subtotal: map['subtotal'],
    );
  }
}