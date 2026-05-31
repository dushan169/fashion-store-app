import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_store_app/models/product.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Product>> getProducts() {
    return _firestore
        .collection('products')
        .snapshots()
        .map((s) => s.docs.map((d) => Product.fromFirestore(d)).toList());
  }

  Stream<List<Product>> getProductsByCategory(String category) {
    return _firestore
        .collection('products')
        .where('category', isEqualTo: category)
        .snapshots()
        .map((s) => s.docs.map((d) => Product.fromFirestore(d)).toList());
  }

  Future<Product?> getProductById(String id) async {
    final doc = await _firestore.collection('products').doc(id).get();
    if (doc.exists) return Product.fromFirestore(doc);
    return null;
  }

  Future<List<String>> getCategories() async {
    final snapshot = await _firestore.collection('products').get();
    final categories = snapshot.docs
        .map((doc) => (doc.data()['category'] ?? '') as String)
        .toSet()
        .toList();
    return ['All', ...categories];
  }
}
