class FoodModel {
  int? id;
  String name;
  int price;
  String description;
  String image;
  int stock;

  FoodModel({
    this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.stock,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'image': image,
      'stock': stock,
    };
  }

  factory FoodModel.fromMap(
      Map<String, dynamic> map) {
    return FoodModel(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      description: map['description'],
      image: map['image'],
      stock: map['stock'],
    );
  }
}