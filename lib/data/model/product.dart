import "dart:ffi";

class Product {
  final String? id;
  final String title;
  final String brand;
  final String category;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String? thumbnail;

  Product(
      {this.id,
      required this.title,
      required this.brand,
      required this.category,
      required this.description,
      required this.price,
      required this.discountPercentage,
      required this.rating,
      required this.stock,
      this.thumbnail});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "brand": brand,
      "category": category,
      "description": description,
      "price": price,
      "discountPercentage": discountPercentage,
      "rating": rating,
      "stock": stock
    };
  }

  static fromMap(Map<String, dynamic> map) {
    return Product(
      id: map["_id"],
      title: map["title"],
      brand: map["brand"],
      category: map["category"],
      description: map["description"],
      price: map["price"] is int ? map["price"].toDouble() : map["price"],
      discountPercentage: map["discountPercentage"] is int
          ? map["discountPercentage"].toDouble()
          : map["discountPercentage"],
      rating: map["rating"] is int ? map["rating"].toDouble() : map["rating"],
      stock: map["stock"],
      thumbnail: map["thumbnail"],
    );
  }
}
