import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final double? oldPrice;
  final String imageUrl;
  final bool isFavourite;
  final String description;
  final int stock;

  const Product({
    required this.id,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.name,
    required this.price,
    this.oldPrice,
    this.isFavourite = false,
    this.stock = 0,
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      oldPrice: data['oldPrice'] != null ? (data['oldPrice']).toDouble() : null,
      imageUrl: data['imageUrl'] ?? '',
      isFavourite: data['isFavourite'] ?? false,
      description: data['description'] ?? '',
      stock: data['stock'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
        'category': category,
        'price': price,
        'oldPrice': oldPrice,
        'imageUrl': imageUrl,
        'isFavourite': isFavourite,
        'description': description,
        'stock': stock,
      };
}
