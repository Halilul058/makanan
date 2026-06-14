class PaymentModel {
  int? id;
  int orderId;
  String paymentMethod;
  String paymentStatus;
  String paymentDate;

  PaymentModel({
    this.id,
    required this.orderId,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.paymentDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_id': orderId,
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'payment_date': paymentDate,
    };
  }

  factory PaymentModel.fromMap(
      Map<String, dynamic> map) {
    return PaymentModel(
      id: map['id'],
      orderId: map['order_id'],
      paymentMethod: map['payment_method'],
      paymentStatus: map['payment_status'],
      paymentDate: map['payment_date'],
    );
  }
}