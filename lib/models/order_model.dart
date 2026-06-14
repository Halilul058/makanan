class OrderModel {
  int? id;
  int userId;
  int totalPrice;
  String orderDate;
  String status;

  OrderModel({
    this.id,
    required this.userId,
    required this.totalPrice,
    required this.orderDate,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'total_price': totalPrice,
      'order_date': orderDate,
      'status': status,
    };
  }

  factory OrderModel.fromMap(
      Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      userId: map['user_id'],
      totalPrice: map['total_price'],
      orderDate: map['order_date'],
      status: map['status'],
    );
  }
}